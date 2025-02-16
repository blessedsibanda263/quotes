import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:flutter/material.dart';

class ShareIconButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ShareIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.share),
      tooltip: l10n.shareIconButtonTooltip,
    );
  }
}
