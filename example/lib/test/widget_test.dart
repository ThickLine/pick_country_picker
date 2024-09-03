import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

import '../main.dart';

void main() {
  testWidgets('ExampleApp and CountryPickerModal display correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExampleApp());

    // Verify that the app is displayed correctly.
    expect(find.byType(ExampleApp), findsOneWidget);

    // Tap on the 'Show Country Picker' button to open the modal.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for the modal to fully open.

    // Verify the modal is displayed
    expect(find.byType(CountryPickerModal), findsOneWidget);
  });
}
