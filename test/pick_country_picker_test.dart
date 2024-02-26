import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pick_country_picker/pick_country_picker.dart';
import 'package:pick_country_picker/src/models/country.dart';

void main() {
  testWidgets('CountryPickerModal displays correctly',
      (WidgetTester tester) async {
    Country? selectedCountry = Country(
      countryCode: "371",
      iso2Code: "LV",
      e164CountryCode: 0,
      isGeographic: true,
      tierLevel: 1,
      countryName: "Latvia",
      dialExample: "2012345678",
      formattedDisplayName: "Latvia (LV) [+371]",
      fullDialExampleWithPlusSign: "+3712012345678",
      displayNameWithoutCountryCode: "Latvia (LV)",
      e164Key: "371-LV-0",
      flagUri: "assets/flags/lv.png",
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
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
                      onCountryChanged: (Country country) {
                        selectedCountry = country;
                      },
                    ),
                  ),
                );
              },
              child: const Text('Show Country Picker'),
            );
          },
        ),
      ),
    ));

    // Tap the button to show the country picker
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify the modal is displayed
    expect(find.byType(CountryPickerModal), findsOneWidget);
  });
}
