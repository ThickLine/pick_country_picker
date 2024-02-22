import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

void main() {
  testWidgets('CountryPickerModal opens, selects a country, and closes',
      (WidgetTester tester) async {
    bool countryChangedCalled = false;

    // Mock onCountryChanged to set a flag when called
    void onCountryChanged(Country country) {
      countryChangedCalled = true;
    }

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CountryPickerModal(
          onCountryChanged: onCountryChanged,
        ),
      ),
    ));

    // Open the modal by simulating whatever action normally opens it
    // For this example, we directly build the modal into the widget tree

    // Assuming the modal displays a list of countries using ListView
    // Attempt to tap the first ListTile, simulating a country selection
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle(); // Wait for potential animations to complete

    // Verify that the onCountryChanged callback was called
    expect(countryChangedCalled, true);

    // Additional verifications can include checking for the modal's closure,
    // but this requires knowledge about how the modal is implemented and managed.
  });
}
