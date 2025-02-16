import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:flutter/material.dart';

class GenericErrorSnackbarAlert extends SnackBar {
  const GenericErrorSnackbarAlert({super.key})
    : super(content: const _GenericErrorSnackBarMessage());
}

class _GenericErrorSnackBarMessage extends StatelessWidget {
  const _GenericErrorSnackBarMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return Text(l10n.genericErrorSnackbarMessage);
  }
}
