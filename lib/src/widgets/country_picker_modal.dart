import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_country_picker/src/models/country.dart';
import '../data/country_codes.dart';
import 'package:collection/collection.dart';

/// A modal widget that allows the user to pick a country from a list.
///
/// This widget is highly customizable, offering the ability to override the default list of countries,
/// prioritize certain countries, and use custom widgets for various elements like the search field and country list items.
class CountryPickerModal extends StatefulWidget {
  /// Callback function triggered when a country is selected. Passes the selected [Country].
  final Function(Country) onCountryChanged;

  /// ISO 3166-1 alpha-2 country code of the initially selected country. Highlighted and shown at the top if provided.
  final String? selectedCountryIdentifier;

  /// Title for the picker modal. Defaults to 'Select Country'.
  final String title;

  /// Country codes to be prioritized and shown at the top of the list.
  final List<String>? priorityCountryCodes;

  /// Custom widget for the search field. A default search field is used if not provided.
  final Widget? searchField;

  /// Custom builder function for displaying each country in the list.
  final Widget Function(Country)? countryListItemBuilder;

  /// Custom widget displayed next to the selected country. Defaults to a checkmark icon.
  final Widget? selectedIcon;

  /// List of country codes to limit the countries available for selection. Overrides the default list.
  final List<String>? overrideCountryCodes;

  /// Hides the search bar when set to true. Defaults to false.
  final bool hideSearch;

  /// Hides the close icon in the dialog when set to true. Defaults to false.
  final bool hideCloseIcon;

  /// Custom widget for the back button. Defaults to a back button.
  final Widget? backButton;

  /// Border radius for the modal. Defaults to 0.0.
  final BorderRadiusGeometry? borderRadius;

  /// Use Cupertino modal instead of Material modal. Defaults to false.
  final bool useCupertinoModal;

  /// Custom builder function for displaying each country in the list.
  final String Function(Country)? countryDisplayBuilder;

  /// Custom builder function for displaying the flag of each country in the list.
  final Widget Function(Country)? flagBuilder;

  const CountryPickerModal({
    Key? key,
    required this.onCountryChanged,
    this.selectedCountryIdentifier,
    this.title = 'Select Country',
    this.priorityCountryCodes,
    this.searchField,
    this.countryListItemBuilder,
    this.selectedIcon,
    this.overrideCountryCodes,
    this.hideSearch = false,
    this.hideCloseIcon = false,
    this.backButton,
    this.borderRadius,
    this.useCupertinoModal = false,
    this.countryDisplayBuilder,
    this.flagBuilder,
  }) : super(key: key);

  @override
  _CountryPickerModalState createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<CountryPickerModal> {
  List<Country> countries = [];
  List<Country> filteredCountries = [];
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() {
    // Load all countries from JSON or another data source
    List<Country> allCountries =
        countryCodes.map((data) => Country.fromJson(data)).toList();

    // If there's a list of country codes to override the default list, filter the countries list
    if (widget.overrideCountryCodes != null) {
      allCountries = allCountries
          .where((country) =>
              widget.overrideCountryCodes!.contains(country.iso2Code))
          .toList();
    }

    // Apply priority to certain countries if specified
    if (widget.priorityCountryCodes != null &&
        widget.priorityCountryCodes!.isNotEmpty) {
      final List<Country> priorityCountries = allCountries
          .where((country) =>
              widget.priorityCountryCodes!.contains(country.iso2Code))
          .toList();
      final List<Country> remainingCountries = allCountries
          .where((country) =>
              !widget.priorityCountryCodes!.contains(country.iso2Code))
          .toList();
      countries = priorityCountries + remainingCountries;
    } else {
      countries = allCountries;
    }

    // Determine the selected country based on the identifier provided
    if (widget.selectedCountryIdentifier != null) {
      selectedCountry = countries.firstWhereOrNull(
        (country) =>
            country.countryCode == widget.selectedCountryIdentifier ||
            country.iso2Code == widget.selectedCountryIdentifier,
      );

      // If a selected country is found, ensure it's at the top of the list
      if (selectedCountry != null) {
        countries.remove(
            selectedCountry); // Remove the selected country from its current position
        countries.insert(0, selectedCountry!); // Insert it at the top
      }
    }

    filteredCountries =
        List<Country>.from(countries); // Initialize the filteredCountries list
    setState(() {}); // Refresh the widget to reflect changes
  }


  void _filterCountries(String query) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.countryName
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useCupertinoModal) {
      return _buildCupertinoModal();
    } else {
      return _buildDefaultModal();
    }
  }

  Widget _buildCupertinoModal() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        automaticallyImplyLeading: !widget.hideCloseIcon,
        leading: !widget.hideCloseIcon
            ? widget.backButton ??
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(CupertinoIcons.back, size: 24),
                  onPressed: () => Navigator.of(context).pop(),
                )
            : null,
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (!widget.hideSearch)
              widget.searchField ??
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      onChanged: _filterCountries,
                      placeholder: 'Search',
                      clearButtonMode: OverlayVisibilityMode.editing,
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  var country = filteredCountries[index];
                  bool isSelected = country == selectedCountry;

                  return widget.countryListItemBuilder?.call(country) ??
                      _defaultCountryListItem(country, isSelected);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultModal() {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !widget.hideCloseIcon,
          leading: widget.backButton ??
              BackButton(onPressed: () => Navigator.of(context).pop()),
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            if (!widget.hideSearch)
              widget.searchField ??
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: _filterCountries,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  var country = filteredCountries[index];
                  bool isSelected = country == selectedCountry;


                  return widget.countryListItemBuilder?.call(country) ??
                      _defaultCountryListItem(country, isSelected);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Default list item builder
  Widget _defaultCountryListItem(Country country, bool isSelected) {
    return ListTile(
      leading: widget.flagBuilder != null
          ? widget.flagBuilder!(country)
          : SizedBox(
              width: 50,
              height: 30,
              child: Image.asset(
                country.flagUri!,
                fit: BoxFit.cover,
                package: 'pick_country_picker',
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.circle),
              ),
            ),
      title: Text(widget.countryDisplayBuilder != null
          ? widget.countryDisplayBuilder!(country)
          : "${country.countryName} (${country.iso2Code}) [+${country.countryCode}]"),
      trailing: isSelected
          ? widget.selectedIcon ??
              const Icon(Icons.check_circle, color: Colors.green)
          : const SizedBox(),
      onTap: () {
        widget.onCountryChanged(country);
        Navigator.of(context).pop();
      },
    );
  }
}
