import 'package:collection/collection.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import 'package:pick_country_picker/src/data/country_codes.dart';

class PickCountryLookupService {
  final List<Country> _allCountries;

  PickCountryLookupService()
      : _allCountries =
            countryCodes.map((code) => Country.fromJson(code)).toList();

// Fetch a country by its ISO code
  Country? getCountryByIsoCode(String isoCode) {
    return _allCountries
        .firstWhereOrNull((country) => country.iso2Code == isoCode);
  }

  // Fetch a country by its country code
  Country? getCountryByCountryCode(String countryCode) {
    return _allCountries
        .firstWhereOrNull((country) => country.countryCode == countryCode);
  }

  // Fetch a country by its name
  Country? getCountryByName(String countryName) {
    return _allCountries.firstWhereOrNull((country) =>
        country.countryName.toLowerCase() == countryName.toLowerCase());
  }
}
