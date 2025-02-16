import 'package:component_library/src/l10n/component_library_localizations.dart';

class ComponentLibraryLocalizationsEn extends ComponentLibraryLocalizations {
  ComponentLibraryLocalizationsEn([super.locale = 'en']);

  @override
  String get authenticationRequiredErrorSnackbarMessage =>
      'You need to sign in before performing this action.';

  @override
  String get downvoteIconButtonTooltip => 'Downvote';

  @override
  String get exceptionIndicatorGenericMessage =>
      'There has been an error.\nPlease, check your internet connection and try again later.';

  @override
  String get exceptionIndicatorGenericTitle => 'Something went wrong';

  @override
  String get exceptionIndicatorTryAgainButton => 'Try again';

  @override
  String get favoriteIconButtonTooltip => 'Favorite';

  @override
  String get genericErrorSnackbarMessage =>
      'There has been an error. Please, check your internet connection.';

  @override
  String get searchBarHintText => 'journey';

  @override
  String get searchBarLabelText => 'Search';

  @override
  String get shareIconButtonTooltip => 'Share';

  @override
  String get upvoteIconButtonTooltip => 'Upvote';
}
