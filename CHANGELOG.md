##  3.1.0

* New Features:
  - Added `hideNavigationBar` property to control navigation bar visibility
  - Added enhanced `navigationBar` (iOS) property for complete Cupertino navigation bar customization
  - Added enhanced `appBar` (Android) property for complete Material navigation bar customization
  - Enhanced navigation bar handling to respect both explicit null values and hideNavigationBar setting
* Documentation:
  - Improved documentation for navigation bar properties with detailed examples
  - Added clear usage examples for custom navigation bars in both Cupertino and Material styles
* Testing:
  - Added comprehensive test suite for navigation bar features
  - Added test coverage for Material and Cupertino navigation bar customization
  - Added test cases for hideNavigationBar property interactions

##  3.0.0

* Breaking Changes:
  - Removed `searchField` property
* New Features:
  - Added `customSearchField` property for complete search field override
  - Enhanced `SearchFieldWidget` with extensive customization options:
    - `searchPrefixIcon`
    - `searchSuffixIcon`
    - `searchTextStyle`
    - `searchPlaceholderStyle`
    - `searchDecoration`
    - `searchBoxDecoration`
    - `searchCursorColor`
    - `searchBorderRadius`
    - `searchContentPadding`
    - `onSearchTap`
    - `onSearchSubmitted`
    - `searchAutofocus`
    - `searchFocusNode`
    - `searchBackgroundColor`
    - `searchEnabled`
* Improvements:
  - Significantly improved search field customization without requiring a complete override
  - Enhanced flexibility in styling and behavior of the search field

##  2.0.0

* Breaking Changes:
  - Bump to follow Semantic Versioning

##  1.2.0

* Breaking Changes:
  - `borderBuilder` now accepts a `Widget` input instead of `Border`
* New Features:
  - Added `excludedCountryCodes` from `PickCountryLookupService`

##  1.1.0

* New Features:
  - Added `excludedCountryCodes` option to exclude specific countries from code execution

##  1.0.0

* Initial stable release

##  0.0.3

* Code Cleanup:
  - Improved code efficiency by removing unused code and optimizing existing functionalities
* Documentation:
  - Added a practical example to the README to help new users get started more easily

##  0.0.2

* Initial release