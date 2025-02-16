import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  static const double _elevatedButtonHeight = 48;

  final String label;
  final Widget? icon;
  final VoidCallback? onTap;

  const ExpandedElevatedButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  ExpandedElevatedButton.inProgress({required String label, Key? key})
    : this(
        label: label,
        icon: Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(),
        ),
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child:
          icon != null
              ? ElevatedButton.icon(
                onPressed: onTap,
                label: Text(label),
                icon: icon,
              )
              : ElevatedButton(onPressed: onTap, child: Text(label)),
    );
  }
}
