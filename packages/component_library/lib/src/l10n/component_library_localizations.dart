import 'package:component_library/src/l10n/component_library_localizations_en.dart';
import 'package:component_library/src/l10n/component_library_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

abstract class ComponentLibraryLocalizations {
  final String localeName;

  ComponentLibraryLocalizations(String locale)
    : localeName = Intl.canonicalizedLocale(locale.toString());

  static ComponentLibraryLocalizations of(BuildContext context) {
    return Localizations.of<ComponentLibraryLocalizations>(
      context,
      ComponentLibraryLocalizations,
    )!;
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  String get downvoteIconButtonTooltip;
  String get upvoteIconButtonTooltip;
  String get searchBarHintText;
  String get searchBarLabelText;
  String get shareIconButtonTooltip;
  String get favoriteIconButtonTooltip;
  String get exceptionIndicatorGenericTitle;
  String get exceptionIndicatorTryAgainButton;
  String get exceptionIndicatorGenericMessage;
  String get genericErrorSnackbarMessage;
  String get authenticationRequiredErrorSnackbarMessage;

  static const List<Locale> supportedLocales = [Locale('en'), Locale('pt')];

  static const LocalizationsDelegate<ComponentLibraryLocalizations> delegate =
      _ComponentLibraryLocalizationsDelegate();
}

class _ComponentLibraryLocalizationsDelegate
    extends LocalizationsDelegate<ComponentLibraryLocalizations> {
  const _ComponentLibraryLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<ComponentLibraryLocalizations> load(Locale locale) {
    return SynchronousFuture<ComponentLibraryLocalizations>(
      lookupComponentLibraryLocalizations(locale),
    );
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<ComponentLibraryLocalizations> old,
  ) {
    return false;
  }
}

ComponentLibraryLocalizations lookupComponentLibraryLocalizations(
  Locale locale,
) {
  switch (locale.languageCode) {
    case 'en':
      return ComponentLibraryLocalizationsEn();
    case 'pt':
      return ComponentLibraryLocalizationsPt();
  }
  throw FlutterError(
    'ComponentLibraryLocalizations.delegate failed to load unsupported locale "$locale"',
  );
}
