import 'package:component_library/src/theme/spacing.dart';
import 'package:flutter/material.dart';

class RowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> children;

  const RowAppBar({super.key, this.children = const []});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: Spacing.small,
          left: Spacing.small,
          right: Spacing.small,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const BackButton(), ...children],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
