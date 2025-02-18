import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:flutter/material.dart';

class SearchBarL extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchBarL({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        hintText: l10n.searchBarHintText,
        labelText: l10n.searchBarLabelText,
      ),
      onChanged: onChanged,
    );
  }
}
