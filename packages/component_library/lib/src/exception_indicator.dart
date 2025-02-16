import 'package:component_library/src/expanded_elevated_button.dart';
import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:component_library/src/theme/font_size.dart';
import 'package:component_library/src/theme/spacing.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  const ExceptionIndicator({
    super.key,
    this.title,
    this.message,
    this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 48),
            const SizedBox(height: Spacing.xxLarge),
            Text(
              title ?? l10n.exceptionIndicatorGenericTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: FontSize.mediumLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title ?? l10n.exceptionIndicatorGenericMessage,
              textAlign: TextAlign.center,
            ),
            if (onTryAgain != null) const SizedBox(height: Spacing.xxLarge),
            if (onTryAgain != null)
              ExpandedElevatedButton(
                label: l10n.exceptionIndicatorTryAgainButton,
                onTap: onTryAgain,
                icon: const Icon(Icons.refresh),
              ),
          ],
        ),
      ),
    );
  }
}
