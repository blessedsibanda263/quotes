import 'package:component_library/src/count_indicator_icon_button.dart';
import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:component_library/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class UpvoteIconButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;
  final bool isUpvoted;

  const UpvoteIconButton({
    super.key,
    required this.count,
    required this.isUpvoted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = AppTheme.of(context);
    return CountIndicatorIconButton(
      count: count,
      iconData: Icons.arrow_upward_sharp,
      tooltip: l10n.downvoteIconButtonTooltip,
      iconColor: isUpvoted ? theme.votedButtonColor : theme.unvotedButtonColor,
    );
  }
}
