import 'package:pick_country_picker/src/models/country.dart';
import '../data/country_codes.dart';

class CountryService {
  final List<Country> allCountries;

  CountryService()
      : allCountries =
            countryCodes.map((code) => Country.fromJson(code)).toList();

  List<Country> filterAndSortCountries({
    List<String>? overrideCountryCodes,
    List<String>? priorityCountryCodes,
    List<String>? excludedCountryCodes,
    Country? selectedCountry,
  }) {
    var countries = List<Country>.from(allCountries);

    if (overrideCountryCodes != null) {
      countries = countries
          .where((country) => overrideCountryCodes.contains(country.iso2Code))
          .toList();
    }

    if (priorityCountryCodes != null) {
      final priorityCountries = countries
          .where((country) => priorityCountryCodes.contains(country.iso2Code))
          .toList();
      final otherCountries = countries
          .where((country) => !priorityCountryCodes.contains(country.iso2Code))
          .toList();
      countries = priorityCountries + otherCountries;
    }

    if (excludedCountryCodes != null) {
      countries.removeWhere(
          (country) => excludedCountryCodes.contains(country.iso2Code));
    }

    if (selectedCountry != null) {
      final selectedIndex = countries
          .indexWhere(
          (country) => country.iso2Code == selectedCountry.iso2Code);
      if (selectedIndex != -1) {
        final selectedCountry = countries.removeAt(selectedIndex);
        countries.insert(0, selectedCountry);
      }
    }

    return countries;
  }

}
