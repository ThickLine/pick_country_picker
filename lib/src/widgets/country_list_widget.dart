import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

class CountryListWidget extends StatelessWidget {
  final List<Country> availableCountries;
  final Country? selectedCountry;
  final Function(Country) onCountrySelected;
  final Widget Function(Country country)? flagBuilder;
  final Widget? selectedIcon;
  final String Function(Country country)? countryDisplayBuilder;
  final String? Function(Country country)? subtitleBuilder;
  final Border Function(Country country)? borderBuilder;

  const CountryListWidget({
    Key? key,
    required this.availableCountries,
    required this.selectedCountry,
    required this.onCountrySelected,
    this.flagBuilder,
    this.selectedIcon,
    this.countryDisplayBuilder,
    this.subtitleBuilder,
    this.borderBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: availableCountries.length,
      itemBuilder: (context, index) {
        final country = availableCountries[index];
        final isSelected = selectedCountry != null &&
            country.iso2Code == selectedCountry!.iso2Code;

        return Container(
          decoration: BoxDecoration(
            border: borderBuilder != null ? borderBuilder!(country) : null,
          ),
          child: ListTile(
            leading: flagBuilder != null
                ? flagBuilder!(country)
                : defaultFlagWidget(country),
            title: Text(countryDisplayBuilder != null
                ? countryDisplayBuilder!(country)
                : defaultCountryDisplay(country)),
            subtitle: subtitleBuilder != null
                ? Text(subtitleBuilder!(country) ?? '')
                : null,
            trailing: isSelected
                ? selectedIcon ??
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                : null,
            onTap: () => onCountrySelected(country),
          ),
        );
      },
    );
  }

  // Example default widget implementations
  Widget defaultFlagWidget(Country country) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        country.flagUri!,
        package: 'pick_country_picker',
        width: 32.0,
        height: 20.0,
        fit: BoxFit.cover,
      ),
    );
  }

  String defaultCountryDisplay(Country country) {
    return '${country.countryName} (${country.iso2Code})';
  }

  Widget defaultSubtitleWidget(Country country) {
    return Text('+${country.countryCode}');
  }
}
