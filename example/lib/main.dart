import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Picker Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pickCountryLookupService = PickCountryLookupService();
  String? selectedCountryCode = 'lv';
  Country? selectedCountry;

  @override
  void initState() {
    selectedCountry = _pickCountryLookupService.getCountryByIsoCode("LV");
    super.initState();
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.95,
        child: CountryPickerModal(
          hideCloseIcon: false,
          hideSearch: false,
          selectedCountry: selectedCountry,
          useCupertinoModal: true,
          title: 'Select your country',
          priorityCountryCodes: ['SWE', 'EE', 'LT'],
          overrideCountryCodes: ['LV', 'LT', 'EE'],
          subtitleBuilder: (Country country) {
            return country.countryName;
          },
          onCountryChanged: (Country country) {
            setState(() {
              selectedCountryCode = country.iso2Code;
              selectedCountry = country;
            });
          },

          borderBuilder: (Country country) {
            if (country == selectedCountry) {
              return Border();
            }
            return const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5));
          },

          countryDisplayBuilder: (Country country) {
            return '${country.countryName}';
          },
          flagBuilder: (Country country) {
            return CircleAvatar(
              backgroundImage: AssetImage(
                country.flagUri!,
                package: 'pick_country_picker',
              ),
              onBackgroundImageError: (exception, stackTrace) =>
                  Icon(Icons.flag),
            );
          },
          selectedIcon: Icon(Icons.check, color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showCountryPicker(context),
              child: Text('Show Country Picker'),
            ),
            SizedBox(height: 20),
            Text('Selected Country: $selectedCountryCode'),
            Text('Selected Country: ${selectedCountry?.countryName ?? 'None'}'),
            Image.asset(
              selectedCountry?.flagUri ?? "",
              package: 'pick_country_picker',
              width: 32.0,
              height: 20.0,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
