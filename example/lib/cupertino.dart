import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Picker Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
          selectedCountryIsoCode: selectedCountry?.iso2Code,
          title: 'Select your country',
          priorityCountryCodes: const ['US', 'CA', 'GB', 'LV'],
          onCountryChanged: (Country country) {
            setState(() => selectedCountry = country);
            Navigator.of(context).pop();
          },
          countryDisplayBuilder: (Country country) {
            return country.countryName;
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
        title: const Text('Country Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showCountryPicker,
              child: const Text('Show Country Picker'),
            ),
            const SizedBox(height: 20),
            if (selectedCountry != null) ...[
              Text('Selected Country: ${selectedCountry!.countryName}'),
              const SizedBox(height: 10),
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
