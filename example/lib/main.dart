import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          hideSearch: true,
          backButton: Container(),
          selectedCountryIsoCode: selectedCountry?.iso2Code,
          title: 'Select your country',
          searchField: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: Colors.grey[400]),
              SizedBox(width: 8),
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ],
          ),
          priorityCountryCodes: ['US', 'CA', 'GB', 'LV'],
          onCountryChanged: (Country country) {
            setState(() => selectedCountry = country);
            Navigator.of(context).pop();
          },
          countryDisplayBuilder: (Country country) {
            return '${country.countryName}';
          },
          subtitleBuilder: (Country country) {
            return '+${country.countryCode}';
          },
          flagBuilder: (Country country) {
            return Image.asset(
              country.flagUri!,
              package: 'pick_country_picker',
              width: 32,
              height: 20,
            );
          },
          borderBuilder: (Country country) {
            return Border.all(
              color: Colors.grey[400]!,
              width: 0.5,
            );
          },
          // selectedIcon: Icon(
          //   Icons.fingerprint_outlined,
          //   color: Colors.pink[200],
          // ),
          useCupertinoModal: false, // Set to false to use Material design
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
