 # CountryPickerModal

A highly customizable modal widget for Flutter that allows users to pick a country from a list. This package is designed for ease of use and extensive customization, supporting both Material and Cupertino modal styles, custom list items, search functionality, and more.

## Features

- **Customization:** Override the default list of countries, prioritize countries, and use custom widgets for search fields, country list items, and selection icons.
- **Material and Cupertino Support:** Choose between Material or Cupertino modal styles to match your app's design.
- **Search Functionality:** Includes a search bar to quickly find countries by name.
- **Custom List Items:** Customize the appearance of country list items with a builder function.
- **Selection Feedback:** Display a custom icon next to the selected country.

## Installation


1. Depend on it
Add this to your package's pubspec.yaml file:

```dart dependencies:
 pick_country_picker: ^0.0.1
 ```
2. Install it
You can install packages from the command line:

with pub:

`$ pub get`
with Flutter:
```dart
$ flutter pub get
```


3. Import it
Now in your Dart code, you can use:
```dart
import 'package:pick_country_picker/pick_country_picker.dart';
  ```


## Usage

To show the country picker modal, create a CountryPickerModal widget:

```dart
import 'package:flutter/material.dart';
import 'package:pick_country_picker/pick_country_picker.dart';

void _showCountryPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return CountryPickerModal(
        onCountryChanged: (Country country) {
          // Handle country selection
          print("Selected country: ${country.countryName}");
        },
      );
    },
  );
}

```

## Customization

Customize the country picker modal by setting its properties:

```dart
CountryPickerModal(
  onCountryChanged: (Country country) {},
  selectedCountryCode: 'US',
  title: 'Select Your Country',
  priorityCountryCodes: ['US', 'CA'],
  searchField: TextField(decoration: InputDecoration(labelText: 'Search...')),
  countryListItemBuilder: (Country country) {
    return ListTile(
      title: Text(country.countryName),
      leading: Image.asset(country.flagUri),
    );
  },
  selectedIcon: Icon(Icons.check_circle, color: Colors.green),
  overrideCountryCodes: ['US', 'CA', 'GB'],
  hideSearch: false,
  hideCloseIcon: false,
  backButton: Icon(Icons.arrow_back),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
   borderBuilder: (Country country) {
            return Border.all(
              color: Colors.grey[400]!,
              width: 0.5,
     );
 },
  useCupertinoModal: false,
)
```

## Example

https://github.com/ThickLine/pick_country_picker/assets/31936990/22e7515c-8668-419e-8fbe-b8e002df9ec5



### With search:

![Picker-with-search Medium](https://github.com/ThickLine/pick_country_picker/assets/31936990/99f79d9b-4540-4408-8f82-0f71b16e2a0c)



### Without search:
![Picker-without-search Medium](https://github.com/ThickLine/pick_country_picker/assets/31936990/6115ad39-e39f-44ac-965c-8cc9da62d9a3)

### Build your own:
![Picker-build-your-own Medium](https://github.com/ThickLine/pick_country_picker/assets/31936990/7390a1d5-d9e1-4177-bb2a-c86174a08554)



An example application demonstrating the usage of CountryPickerModal is included in the example directory of the package.

For more information and additional customization options, please refer to the package documentation.

