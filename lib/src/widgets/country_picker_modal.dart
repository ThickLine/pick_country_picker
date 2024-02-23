import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import 'package:pick_country_picker/src/services/country_service.dart';
import 'package:pick_country_picker/src/widgets/country_list_widget.dart';
import 'package:pick_country_picker/src/widgets/search_field_widget.dart';
import 'package:collection/collection.dart';

/// A modal widget that allows the user to pick a country from a list.
///
/// Offers extensive customization options, including overriding the default country list,
/// specifying priority countries, and using custom widgets for the search field, list items, and more.
class CountryPickerModal extends StatefulWidget {
  /// Invoked when a country is selected by the user. Passes the selected [Country] object.
  final Function(Country) onCountryChanged;

  /// Identifier (ISO 3166-1 alpha-2 code or country code) for pre-selecting a country in the picker.
  /// If provided, the corresponding country will be highlighted and positioned at the top of the list.
  final String? selectedCountryIdentifier;

  /// Custom title for the country picker modal. Defaults to 'Select Country'.
  /// Useful for localization or when a different modal title is desired.
  final String title;

  /// List of country ISO codes that should be given priority in the list.
  /// Countries specified here will appear at the top of the list, making them more accessible to the user.
  final List<String>? priorityCountryCodes;

  /// List of country ISO codes to limit the countries shown in the picker.
  /// Only countries with codes in this list will be available for selection, effectively overriding the default country list.
  final List<String>? overrideCountryCodes;

  /// Controls the visibility of the search functionality within the picker.
  /// If set to true, the search field will be hidden, limiting users to scrolling through the country list.
  final bool hideSearch;

  /// Determines whether the close icon or back button is visible in the modal.
  /// Useful for custom navigation flows where the default back behavior is not desired.
  final bool hideCloseIcon;

  /// Switches the modal design between Cupertino and Material styles.
  /// Set to true for Cupertino (iOS) style, or false for Material (Android) style.
  final bool useCupertinoModal;

  /// Custom widget for the search field, allowing for full customization of its appearance and functionality.
  /// If not provided, a default search field is used.
  final Widget? searchField;

  /// Custom widget for the back or close button in the modal's app bar.
  /// Provides a way to customize the appearance or behavior of the back navigation.
  final Widget? backButton;

  /// Builder function for customizing the appearance and layout of each country item in the list.
  /// Enables complete control over how each country is displayed, including the flag, name, and selection indicator.
  final Widget Function(Country)? countryListItemBuilder;

  /// Builder function for creating custom subtitle text for each country list item.
  /// Allows for additional information to be displayed under the country name.
  final String Function(Country)? subtitleBuilder;

  /// Custom widget to indicate the selected country in the list.
  /// Overrides the default selection indicator, providing flexibility in how selection is highlighted.
  final Widget? selectedIcon;

  /// Builder function to customize the display text for each country, overriding the default display.
  /// Useful for custom formatting of country names.
  final String Function(Country)? countryDisplayBuilder;

  /// Builder function to create a custom flag widget for each country, overriding the default flag display.
  /// Offers the ability to use custom images or styles for country flags.
  final Widget Function(Country)? flagBuilder;

  /// Custom border radius for the modal, applicable to Cupertino style modals.
  /// Allows for rounded corners, enhancing the modal's visual integration with the rest of the UI.
  final BorderRadiusGeometry? borderRadius;

  /// Custom text for the cancel button, applicable in Cupertino style modals.
  /// Allows for localization or customization of the button text.
  final String cancelText;

  /// Placeholder text for the search field, providing guidance on what users can search for.
  /// Defaults to 'Search for a country', but can be customized for localization or clarity.
  final String placeholderText;

  const CountryPickerModal(
      {Key? key,
      required this.onCountryChanged,
      this.selectedCountryIdentifier,
      this.title = 'Select Country',
      this.priorityCountryCodes,
      this.overrideCountryCodes,
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
      this.placeholderText = 'Search for a country'})
      : super(key: key);

  @override
  _CountryPickerModalState createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<CountryPickerModal> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
  }

  void _initializeCountries() {
    final countryService = CountryService();
    _countries = countryService.filterAndSortCountries(
      overrideCountryCodes: widget.overrideCountryCodes,
      priorityCountryCodes: widget.priorityCountryCodes,
      selectedCountryCode: widget.selectedCountryIdentifier,
    );

    _selectedCountry = _countries.firstWhereOrNull(
      (country) =>
          country.iso2Code == widget.selectedCountryIdentifier ||
          country.countryCode == widget.selectedCountryIdentifier,
    );

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
        countries: _filteredCountries,
        selectedCountry: _selectedCountry,
        onCountrySelected: (Country country) {
          widget.onCountryChanged(country);
          Navigator.of(context).pop();
        },
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
        if (!widget.hideSearch) _buildSearchField(),
        Expanded(child: _buildCountryPickerList()),
      ],
    );

    if (widget.useCupertinoModal) {
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: [
              if (!widget.hideCloseIcon)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!widget.hideSearch)
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
                // Ensures the list takes the remaining space
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
