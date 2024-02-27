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
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();

    selectedCountry = PickCountryLookupService().getCountryByIsoCode('LV');
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: CountryPickerModal(
          hideCloseIcon: true,
          hideSearch: false,
          backButton: Container(),
          searchField: SizedBox(
            height: 80,
            child: Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Icon smily face
                  Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.grey[800],
                  ),
                  Text("Build your own search bar"),
                  Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
          ),
          selectedCountryIsoCode: selectedCountry?.iso2Code,
          title: 'Select your country',
          priorityCountryCodes: ['US', 'CA', 'GB', 'LV'],
          onCountryChanged: (Country country) {
            setState(() => selectedCountry = country);
          },
          countryDisplayBuilder: (Country country) {
            return '${country.countryName}';
          },
          subtitleBuilder: (Country country) {
            return '+${country.countryCode} (${country.iso2Code})';
          },
          flagBuilder: (Country country) {
            return Image.asset(
              country.flagUri!,
              package: 'pick_country_picker',
              width: 32,
              height: 20,
            );
          },
          useCupertinoModal: true, // Set to false to use Material design
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
          children: <Widget>[
            ElevatedButton(
              onPressed: _showCountryPicker,
              child: Text('Show Country Picker'),
            ),
            SizedBox(height: 20),
            if (selectedCountry != null) ...[
              Text('Selected Country: ${selectedCountry!.countryName}'),
              SizedBox(height: 10),
              Image.asset(
                selectedCountry!.flagUri!,
                package: 'pick_country_picker',
                width: 32,
                height: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
