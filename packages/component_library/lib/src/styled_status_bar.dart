import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Useful for changing the status bar color when the screen doesn't have an AppBar.
class StyledStatusBar extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;

  const StyledStatusBar._({
    super.key,
    required this.child,
    required this.style,
  });

  const StyledStatusBar.light({required Widget child, Key? key})
    : this._(child: child, style: SystemUiOverlayStyle.light, key: key);

  const StyledStatusBar.dark({required Widget child, Key? key})
    : this._(child: child, style: SystemUiOverlayStyle.dark, key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(value: style, child: child);
  }
}
