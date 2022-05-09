import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Represent svg icon.
class SvgIcon extends StatelessWidget {
  const SvgIcon({
    required this.asset,
    this.color,
    this.height,
    Key? key,
  }) : super(key: key);

  /// Path where svg icon stored.
  final String asset;

  /// Svg icon color.
  final Color? color;

  /// Svg icon height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      color: color,
      height: height,
      // fit: BoxFit.cover,
    );
  }
}
