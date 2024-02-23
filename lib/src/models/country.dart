class Country {
  final String countryCode;
  final String iso2Code;
  final int e164CountryCode;
  final bool isGeographic;
  final int tierLevel;
  final String countryName;
  final String dialExample;
  final String formattedDisplayName;
  final String fullDialExampleWithPlusSign;
  final String displayNameWithoutCountryCode;
  final String e164Key;
  final String? flagUri;

  Country({
    required this.countryCode,
    required this.iso2Code,
    required this.e164CountryCode,
    required this.isGeographic,
    required this.tierLevel,
    required this.countryName,
    required this.dialExample,
    required this.formattedDisplayName,
    required this.fullDialExampleWithPlusSign,
    required this.displayNameWithoutCountryCode,
    required this.e164Key,
    this.flagUri,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryCode: json['countryCode'] as String,
      iso2Code: json['iso2Code'] as String,
      e164CountryCode: json['e164CountryCode'] as int,
      isGeographic: json['isGeographic'] as bool,
      tierLevel: json['tierLevel'] as int,
      countryName: json['countryName'] as String,
      dialExample: json['dialExample'] as String,
      formattedDisplayName: json['formattedDisplayName'] as String,
      fullDialExampleWithPlusSign: json['fullDialExampleWithPlusSign'] ?? '',
      displayNameWithoutCountryCode:
          json['displayNameWithoutCountryCode'] as String,
      e164Key: json['e164Key'] as String,
      flagUri: 'assets/flags/${json['iso2Code'].toLowerCase()}.png',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode &&
          iso2Code == other.iso2Code;

  @override
  int get hashCode => countryCode.hashCode ^ iso2Code.hashCode;
}
