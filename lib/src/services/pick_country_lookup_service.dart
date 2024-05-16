import 'package:collection/collection.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import 'package:pick_country_picker/src/data/country_codes.dart';

class PickCountryLookupService {
  final List<Country> _allCountries;
  final List<String>? overrideCountryCodes;


  PickCountryLookupService(
      {this.overrideCountryCodes, List<String>? excludedCountryCodes})
      : _allCountries = countryCodes
            .map((code) => Country.fromJson(code))
            .where((country) =>
                excludedCountryCodes == null ||
                !excludedCountryCodes.contains(country.iso2Code))
            .toList();

  // Fetch a country by its ISO code
  Country? getCountryByIsoCode(String isoCode) {
    return _allCountries.firstWhereOrNull(
        (country) => country.iso2Code.toLowerCase() == isoCode.toLowerCase());
  }

  // Fetch a country by its country code
  Country? getCountryByCountryCode(String countryCode) {
    return _allCountries.firstWhereOrNull((country) =>
        country.countryCode.toLowerCase() == countryCode.toLowerCase());
  }

  // Fetch a country by its name
  Country? getCountryByName(String countryName) {
    return _allCountries.firstWhereOrNull((country) =>
        country.countryName.toLowerCase() == countryName.toLowerCase());
  }
}
