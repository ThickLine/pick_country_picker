import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;
  final bool useCupertino;
  final String placeholder;

  const SearchFieldWidget({
    Key? key,
    required this.controller,
    required this.onSearchChanged,
    this.useCupertino = false,
    this.placeholder = 'Search',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useCupertino
        ? CupertinoSearchTextField(
            controller: controller,
            onChanged: onSearchChanged,
            placeholder: placeholder,
          )
        : TextField(
            controller: controller,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              labelText: placeholder,
              prefixIcon: const Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            ),
          );
  }
}
