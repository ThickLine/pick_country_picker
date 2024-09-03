import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A highly customizable search widget that supports both Material and Cupertino designs.
class SearchFieldWidget extends StatelessWidget {
  /// Controller for the search text field.
  final TextEditingController controller;

  /// Callback function triggered when the search text changes.
  final Function(String) onSearchChanged;

  /// Determines whether to use Cupertino-style widgets (iOS) or Material-style widgets (Android).
  final bool useCupertino;

  /// Placeholder text displayed when the search field is empty.
  final String placeholder;

  /// Widget to be displayed as a prefix icon in the search field.
  final Widget? prefixIcon;

  /// Icon to be displayed as a suffix icon in the search field.
  final Icon? suffixIcon;

  /// Text style for the input text in the search field.
  final TextStyle? textStyle;

  /// Text style for the placeholder text in the search field.
  final TextStyle? placeholderStyle;

  /// Decoration for the Material-style TextField.
  final InputDecoration? decoration;

  /// Decoration for the Cupertino-style search field container.
  final BoxDecoration? boxDecoration;

  /// Color of the text input cursor.
  final Color? cursorColor;

  /// Border radius for the search field container.
  final double? borderRadius;

  /// Padding inside the search field.
  final EdgeInsetsGeometry? contentPadding;

  /// Callback function triggered when the search field is tapped.
  final Function()? onTap;

  /// Callback function triggered when the search is submitted.
  final Function(String)? onSubmitted;

  /// Determines if the search field should be auto-focused when displayed.
  final bool autofocus;

  /// FocusNode for controlling the focus of the search field.
  final FocusNode? focusNode;

  /// Background color of the search field.
  final Color? backgroundColor;

  /// Determines if the search field is enabled or disabled.
  final bool? enabled;

  const SearchFieldWidget({
    super.key,
    required this.controller,
    required this.onSearchChanged,
    this.useCupertino = false,
    this.placeholder = 'Search',
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.placeholderStyle,
    this.decoration,
    this.boxDecoration,
    this.cursorColor,
    this.borderRadius,
    this.contentPadding,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
    this.backgroundColor,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    if (useCupertino) {
      return CupertinoSearchTextField(
        controller: controller,
        onChanged: onSearchChanged,
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        style: textStyle,
        decoration: boxDecoration,
        prefixIcon: prefixIcon ?? const SizedBox.shrink(),
        suffixIcon: suffixIcon ?? const Icon(CupertinoIcons.xmark_circle_fill),
        onTap: onTap,
        onSubmitted: onSubmitted,
        autofocus: autofocus,
        focusNode: focusNode,
        backgroundColor: backgroundColor ?? CupertinoColors.systemGrey6,
        enabled: enabled ?? true,
      );
    } else {
      return TextField(
        controller: controller,
        onChanged: onSearchChanged,
        style: textStyle,
        cursorColor: cursorColor,
        decoration: decoration ??
            InputDecoration(
              hintText: placeholder,
              hintStyle: placeholderStyle,
              prefixIcon: prefixIcon ?? const Icon(Icons.search),
              suffixIcon: suffixIcon,
              filled: backgroundColor != null,
              fillColor: backgroundColor,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
        onTap: onTap,
        onSubmitted: onSubmitted,
        autofocus: autofocus,
        focusNode: focusNode,
        enabled: enabled,
      );
    }
  }
}
