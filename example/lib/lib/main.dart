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
  String? selectedCountryCode = 'US';

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.95,
        child: CountryPickerModal(
          hideCloseIcon: false,
          hideSearch: false,
          selectedCountryIdentifier: selectedCountryCode,
          title: 'Select your country',
          priorityCountryCodes: ['US', 'GB', 'CN'],
          useCupertinoModal: false,
          onCountryChanged: (Country country) {
            setState(() {
              selectedCountryCode = country.iso2Code;
            });
          },
          countryDisplayBuilder: (Country country) {
            // Return a custom string to display for each country
            return '${country.countryName} - ${country.iso2Code}';
          },
          flagBuilder: (Country country) {
            // Return a custom widget to display for each country flag
            return CircleAvatar(
              backgroundImage: AssetImage(
                country.flagUri!,
                package: 'pick_country_picker',
              ),
              onBackgroundImageError: (exception, stackTrace) =>
                  Icon(Icons.flag),
            );
          },
          selectedIcon: Icon(Icons.radio_button_checked, color: Colors.green),
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
          ],
        ),
      ),
    );
  }
}
