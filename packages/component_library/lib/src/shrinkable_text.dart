import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

class ShrinkableText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ShrinkableText({
    super.key,
    required this.data,
    this.style,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(data, style: style, textAlign: textAlign);
  }
}
