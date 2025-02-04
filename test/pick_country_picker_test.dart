import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pick_country_picker/pick_country_picker.dart';


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

  testWidgets('should handle hideNavigationBar property correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CountryPickerModal(
        onCountryChanged: (_) {},
        hideNavigationBar: true,
      ),
    ));

    // Should not find AppBar when hideNavigationBar is true
    expect(find.byType(AppBar), findsNothing);
  });

  testWidgets('should handle custom appBar property correctly',
      (WidgetTester tester) async {
    const customTitle = 'Custom App Bar';
    await tester.pumpWidget(MaterialApp(
      home: CountryPickerModal(
        onCountryChanged: (_) {},
        appBar: AppBar(title: const Text(customTitle)),
      ),
    ));

    // Should find custom AppBar title
    expect(find.text(customTitle), findsOneWidget);
  });

  testWidgets('should handle custom navigationBar in Cupertino style',
      (WidgetTester tester) async {
    const customTitle = 'Custom Nav Bar';
    await tester.pumpWidget(MaterialApp(
      home: CountryPickerModal(
        onCountryChanged: (_) {},
        useCupertinoModal: true,
        navigationBar: const CupertinoNavigationBar(
          middle: Text(customTitle),
        ),
      ),
    ));

    // Should find custom navigation bar title
    expect(find.text(customTitle), findsOneWidget);
  });

  testWidgets('should respect both hideNavigationBar and custom bars',
      (WidgetTester tester) async {
    const customTitle = 'Should Not Show';
    await tester.pumpWidget(MaterialApp(
      home: CountryPickerModal(
        onCountryChanged: (_) {},
        hideNavigationBar: true,
        appBar: AppBar(title: const Text(customTitle)),
      ),
    ));

    // Should not find AppBar or title when hideNavigationBar is true, even with custom appBar
    expect(find.byType(AppBar), findsNothing);
    expect(find.text(customTitle), findsNothing);
  });
}
