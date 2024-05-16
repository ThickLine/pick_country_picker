import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import 'package:pick_country_picker/src/services/country_service.dart';
import 'package:pick_country_picker/src/widgets/country_list_widget.dart';
import 'package:pick_country_picker/src/widgets/search_field_widget.dart';

/// A modal widget that allows the user to pick a country from a list.
///
/// Offers extensive customization options, including overriding the default country list,
/// specifying priority countries, and using custom widgets for the search field, list items, and more.
class CountryPickerModal extends StatefulWidget {
  /// Invoked when the user makes a final country selection.
  /// Passes the newly selected [Country] object to the caller for further processing.
  final Function(Country) onCountryChanged;

  /// An optional ISO 3166-1 alpha-2 code or country code to pre-select a country.
  /// If provided, the specified country will be highlighted and placed at the top of the list.
  final Country? selectedCountry;

  /// Optional parameter to specify the country to be pre-selected using its ISO 3166-1 alpha-2
  /// representation (e.g., 'US' for United States, 'CA' for Canada).
  final String? selectedCountryCode;

  /// Optional parameter to specify the country to be pre-selected using its full country name
  /// (e.g., 'United States', 'Canada').
  final String? selectedCountryName;

  /// Optional parameter to specify the country to be pre-selected using its ISO 3166-1 alpha-2
  ///  ISO code (e.g., 'US', 'CA').
  final String? selectedCountryIsoCode;

  /// Custom title for the modal. Useful for localization or when a different title is preferred
  /// over the default 'Select Country'.
  final String title;

  /// Country ISO codes for countries that should appear at the top of the list.
  /// This improves the discoverability of frequently used or important countries.
  final List<String>? priorityCountryCodes;

  /// Country ISO codes to exclusively display in the picker.
  /// Use this to restrict the selection to a specific set of countries, overriding the default list.
  final List<String>? overrideCountryCodes;

  /// Country ISO codes to exclusively remove from a picker.
  /// Use this to restrict the selection to a specific set of countries, overriding the default list.
  final List<String>? excludedCountryCodes;

  /// Controls whether to display the search field. If true, users can only scroll to find countries.
  final bool hideSearch;

  /// Controls the visibility of the close or back button.
  /// Useful when integrating the picker into custom navigation flows.
  final bool hideCloseIcon;

  /// Switches between Cupertino (iOS) and Material (Android) styles for the modal.
  final bool useCupertinoModal;

  /// Provides a completely custom search field widget.
  /// Use this to tailor the search field's appearance and behavior.
  final Widget? searchField;

  /// Custom widget for the back or close button in the modal's app bar.
  /// Provides a way to customize the appearance or behavior of the back navigation.
  final Widget? backButton;

  /// Builder function for creating a custom country list item.
  /// Enables complete control over how each country is displayed.
  final Widget Function(Country)? countryListItemBuilder;

  /// Builder function for creating custom subtitle text under each country name.
  final String? Function(Country)? subtitleBuilder;

  /// Custom widget to indicate the selected country in the list.
  final Widget? selectedIcon;

  /// Builder function to customize the display text for each country.
  final String Function(Country)? countryDisplayBuilder;

  /// Builder function to create a custom flag widget for each country.
  final Widget Function(Country)? flagBuilder;

  /// Custom border radius for the modal (Cupertino style only).
  final BorderRadiusGeometry? borderRadius;

  /// Custom text for the cancel button (Cupertino style only).
  final String cancelText;

  /// Placeholder text for the search field.
  final String placeholderText;

  /// A callback function that allows for customized border rendering for each country
  /// item in the list. If provided, this function will be used to generate the border
  /// for each ListTile.
  final Widget? borderBuilder;

  CountryPickerModal({
    super.key,
    required this.onCountryChanged,
    this.selectedCountry,
    this.selectedCountryCode,
    this.selectedCountryName,
    this.selectedCountryIsoCode,
    this.title = 'Select Country',
    this.priorityCountryCodes,
    this.overrideCountryCodes,
    this.excludedCountryCodes,
    this.hideSearch = false,
    this.hideCloseIcon = false,
    this.useCupertinoModal = false,
    this.searchField,
    this.backButton,
    this.countryListItemBuilder,
    this.selectedIcon,
    this.countryDisplayBuilder,
    this.flagBuilder,
    this.borderRadius,
    this.subtitleBuilder,
    this.cancelText = 'Cancel',
    this.placeholderText = 'Search for a country',
    this.borderBuilder,
  }) : assert(
          overrideCountryCodes == null ||
              excludedCountryCodes == null ||
              overrideCountryCodes
                  .toSet()
                  .intersection(excludedCountryCodes.toSet())
                  .isEmpty,
          'overrideCountryCodes and excludedCountryCodes must not contain any of the same values.',
        );


  @override
  CountryPickerModalState createState() => CountryPickerModalState();
}

class CountryPickerModalState extends State<CountryPickerModal> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  Country? _selectedCountry;
  Country? initialCountry;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
  }

  void _initializeCountries() {
    final countryService = CountryService();
    final pickCountryLookupService = PickCountryLookupService(
        excludedCountryCodes: widget.excludedCountryCodes);
    _countries = countryService.filterAndSortCountries(
      overrideCountryCodes: widget.overrideCountryCodes,
      priorityCountryCodes: widget.priorityCountryCodes,
      excludedCountryCodes: widget.excludedCountryCodes,
    );

    // Determine the initial country based on the provided properties
    if (_selectedCountry == null) {
      if (widget.selectedCountryCode != null) {
        _selectedCountry = pickCountryLookupService
            .getCountryByCountryCode(widget.selectedCountryCode!);
      } else if (widget.selectedCountry != null) {
        _selectedCountry = widget.selectedCountry;
      } else if (widget.selectedCountryName != null) {
        _selectedCountry = pickCountryLookupService
            .getCountryByName(widget.selectedCountryName!);
      } else if (widget.selectedCountryIsoCode != null) {
        _selectedCountry = pickCountryLookupService
            .getCountryByIsoCode(widget.selectedCountryIsoCode!);
      }
    }

    // If an initial country is determined, place it at the top of the list
    if (_selectedCountry != null) {
      _countries.removeWhere(
          (country) => country.iso2Code == _selectedCountry!.iso2Code);
      _countries.insert(0, _selectedCountry!);
    }

    _filteredCountries = List<Country>.from(_countries);
  }

  void _filterCountries(String query) {
    setState(() {
      _filteredCountries = _countries
          .where((country) =>
              country.countryName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildCountryPickerList() {
    return CountryListWidget(
        availableCountries: _filteredCountries,
        selectedCountry: _selectedCountry,
        onCountrySelected: widget.onCountryChanged,
        borderBuilder: widget.borderBuilder,
        flagBuilder: widget.flagBuilder,
        selectedIcon: widget.selectedIcon,
        countryDisplayBuilder: widget.countryDisplayBuilder,
        subtitleBuilder: widget.subtitleBuilder);
  }

  Widget _buildSearchField() {
    return widget.hideSearch
        ? const SizedBox.shrink()
        : widget.searchField ??
            SearchFieldWidget(
              controller: _searchController,
              onSearchChanged: _filterCountries,
              useCupertino: widget.useCupertinoModal,
              placeholder: widget.placeholderText,
            );
  }

  @override
  Widget build(BuildContext context) {
    final modalContent = Column(
      children: [
        _buildSearchField(),
        Expanded(child: _buildCountryPickerList()),
      ],
    );

    if (widget.useCupertinoModal) {
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildSearchField()),
                    widget.backButton ??
                        CupertinoButton(
                          child: Text(widget.cancelText),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                  ],
                ),
              ),
              Expanded(
                child: _buildCountryPickerList(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: widget.hideCloseIcon
              ? null
              : (widget.backButton ?? const BackButton()),
        ),
        body: modalContent,
      );
    }
  }
}
