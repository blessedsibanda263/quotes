import 'package:component_library/src/theme/spacing.dart';
import 'package:flutter/material.dart';

const _dividerThemeData = DividerThemeData(space: 0);

abstract class AppThemeData {
  ThemeData get materialThemeData;

  double screenMarging = Spacing.mediumLarge;
  double gridSpacing = Spacing.mediumLarge;

  Color get roundedChoiceChipBackgroundColor;
  Color get roundedChoiceChipSelectedBackgroundColor;

  Color get roundedChoiceChipLabelColor;
  Color get roundedChoiceChipSelectedLabelColor;

  Color get roundedChoiceChipAvatarColor;
  Color get roundedChoiceChipSelectedAvatarColor;

  Color get quoteSvgColor;

  Color get unvotedButtonColor;
  Color get votedButtonColor;

  TextStyle quoteTextStyle = const TextStyle(
    fontFamily: 'Fondamento',
    package: 'component_library',
  );
}

extension on Color {
  Map<int, Color> _toSwatch() => {
    50: withValues(alpha: 0.1),
    100: withValues(alpha: 0.2),
    200: withValues(alpha: 0.3),
    300: withValues(alpha: 0.4),
    400: withValues(alpha: 0.5),
    500: withValues(alpha: 0.6),
    600: withValues(alpha: 0.7),
    700: withValues(alpha: 0.8),
    800: withValues(alpha: 0.9),
    900: this,
  };

  MaterialColor toMaterialColor() => MaterialColor(toARGB32(), _toSwatch());
}

class LightAppThemeData extends AppThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.black.toMaterialColor(),
    dividerTheme: _dividerThemeData,
  );

  @override
  Color get roundedChoiceChipBackgroundColor => Colors.white;

  @override
  Color get roundedChoiceChipLabelColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedBackgroundColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedLabelColor => Colors.white;

  @override
  Color get quoteSvgColor => Colors.black;

  @override
  Color get roundedChoiceChipAvatarColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedAvatarColor => Colors.white;

  @override
  Color get unvotedButtonColor => Colors.black54;

  @override
  Color get votedButtonColor => Colors.black;
}

class DarkAppThemeData extends AppThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    primarySwatch: Colors.white.toMaterialColor(),
    dividerTheme: _dividerThemeData,
  );

  @override
  Color get roundedChoiceChipBackgroundColor => Colors.black;

  @override
  Color get roundedChoiceChipLabelColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedBackgroundColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedLabelColor => Colors.black;

  @override
  Color get quoteSvgColor => Colors.white;

  @override
  Color get roundedChoiceChipAvatarColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedAvatarColor => Colors.black;

  @override
  Color get unvotedButtonColor => Colors.white54;

  @override
  Color get votedButtonColor => Colors.white;
}
