import 'package:component_library/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class _SvgAsset extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  const _SvgAsset(
    this.assetPath, {
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$assetPath',
      width: width,
      height: height,
      color: color,
      package: 'component_library',
    );
  }
}

class OpeningQuotesScvgAsset extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const OpeningQuotesScvgAsset({
    super.key,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return _SvgAsset(
      'opening-quote.svg',
      width: width,
      height: height,
      color: theme.quoteSvgColor,
    );
  }
}

class ClosingQuoteSvgAsset extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const ClosingQuoteSvgAsset({super.key, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return _SvgAsset(
      'closing-quote.svg',
      width: width,
      height: height,
      color: theme.quoteSvgColor,
    );
  }
}
