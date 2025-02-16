import 'package:component_library/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedChoiceChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final ValueChanged<bool>? onSelected;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final bool isSelected;

  const RoundedChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.avatar,
    this.labelColor,
    this.selectedLabelColor,
    this.selectedBackgroundColor,
    this.backgroundColor,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return ChoiceChip(
      shape: const StadiumBorder(side: BorderSide()),
      avatar: avatar,
      label: Text(
        label,
        style: TextStyle(
          color:
              isSelected
                  ? (selectedLabelColor ??
                      theme.roundedChoiceChipSelectedLabelColor)
                  : (labelColor ?? theme.roundedChoiceChipLabelColor),
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor:
          (backgroundColor ?? theme.roundedChoiceChipBackgroundColor),
      selectedColor:
          (selectedBackgroundColor ??
              theme.roundedChoiceChipSelectedBackgroundColor),
    );
  }
}
