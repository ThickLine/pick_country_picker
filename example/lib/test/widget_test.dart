import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pick_country_picker_example/main.dart';

void main() {
  testWidgets('CountryPickerModal selection test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ExampleApp());

    // Verify that the initial selected country is 'US'.
    expect(find.text('Selected Country: US'), findsOneWidget);

    // Tap on the 'Show Country Picker' button to open the modal.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for the modal to fully open.
  });
}
