import 'package:component_library/src/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final AppThemeData lightTheme;
  final AppThemeData darkTheme;

  const AppTheme({
    required super.child,
    required this.lightTheme,
    required this.darkTheme,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return oldWidget.lightTheme != lightTheme ||
        oldWidget.darkTheme != darkTheme;
  }

  static AppThemeData of(BuildContext context) {
    final AppTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(inheritedTheme != null, 'No AppTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
