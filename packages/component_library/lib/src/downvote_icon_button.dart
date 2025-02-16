import 'package:component_library/src/count_indicator_icon_button.dart';
import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:component_library/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DownvoteIconButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;
  final bool isDownvoted;

  const DownvoteIconButton({
    super.key,
    required this.count,
    required this.isDownvoted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = AppTheme.of(context);
    return CountIndicatorIconButton(
      count: count,
      iconData: Icons.arrow_downward_sharp,
      tooltip: l10n.downvoteIconButtonTooltip,
      iconColor:
          isDownvoted ? theme.votedButtonColor : theme.unvotedButtonColor,
    );
  }
}
