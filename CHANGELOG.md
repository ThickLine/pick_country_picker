
##  0.0.2



* Initial release.



##  0.0.3



* Code Cleanup: Improved code efficiency by removing unused code and optimizing existing functionalities.

* Documentation: Added a practical example to the README to help new users get started more easily.



##  1.0.0

* Release



##  1.1.0

* Added `excludedCountryCodes` option to exclude specific countries from code execution



##  1.2.0

* Breaking Changes

Breaking: `borderBuilder` now accepts a `Widget` input instead of `Border`

* New Features

Added `excludedCountryCodes` from `PickCountryLookupService`



##  2.0.0

* bump to follow Semantic Versioning



##  3.0.0


-   Breaking Changes:
    -   Removed `searchField` property
-   New Features:
    -   Added `customSearchField` property for complete search field override
    -   Enhanced `SearchFieldWidget` with extensive customization options:
        -   `searchPrefixIcon`
        -   `searchSuffixIcon`
        -   `searchTextStyle`
        -   `searchPlaceholderStyle`
        -   `searchDecoration`
        -   `searchBoxDecoration`
        -   `searchCursorColor`
        -   `searchBorderRadius`
        -   `searchContentPadding`
        -   `onSearchTap`
        -   `onSearchSubmitted`
        -   `searchAutofocus`
        -   `searchFocusNode`
        -   `searchBackgroundColor`
        -   `searchEnabled`
-   Improvements:
    -   Significantly improved search field customization without requiring a complete override
    -   Enhanced flexibility in styling and behavior of th