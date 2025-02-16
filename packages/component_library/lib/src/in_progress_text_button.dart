import 'package:flutter/material.dart';

class InProgressTextButton extends StatelessWidget {
  final String label;

  const InProgressTextButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: null,
      label: Text(label),
      icon: Transform.scale(
        scale: 0.5,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
