import 'package:component_library/src/theme/font_size.dart';
import 'package:flutter/material.dart';

class ChevronListTile extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const ChevronListTile({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: FontSize.mediumLarge),
      ),
      trailing: const Icon(Icons.chevron_right_outlined),
      onTap: onTap,
    );
  }
}
