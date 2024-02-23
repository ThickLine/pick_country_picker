import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

class CountryListWidget extends StatelessWidget {
  final List<Country> countries;
  final Country? selectedCountry;
  final Function(Country) onCountrySelected;
  final Widget Function(Country)? flagBuilder;
  final Widget? selectedIcon;
  final String Function(Country)? countryDisplayBuilder;
  final String Function(Country)? subtitleBuilder;

  const CountryListWidget({
    Key? key,
    required this.countries,
    this.selectedCountry,
    required this.onCountrySelected,
    this.flagBuilder,
    this.selectedIcon,
    this.countryDisplayBuilder,
    this.subtitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        final isSelected = selectedCountry != null &&
            country.iso2Code == selectedCountry!.iso2Code;

        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.separator,
                width: 0.0,
              ),
            ),
          ),
          child: ListTile(
            leading: flagBuilder != null
                ? flagBuilder!(country)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset(
                      country.flagUri!,
                      width: 32.0,
                      height: 20.0,
                      fit: BoxFit.cover,
                      package: 'pick_country_picker',
                    ),
                  ),
            title: Text(countryDisplayBuilder != null
                ? countryDisplayBuilder!(country)
                : "${country.countryName} (${country.iso2Code})"),
            subtitle: Text(subtitleBuilder != null
                ? subtitleBuilder!(country)
                : '+${country.countryCode}'),
            trailing: isSelected
                ? selectedIcon ??
                    const Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: CupertinoColors.activeGreen,
                    )
                : null,
            onTap: () => onCountrySelected(country),
          ),
        );
      },
    );
  }
}
