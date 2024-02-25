import 'package:flutter/material.dart';

import '../../theme/app_dimensions.dart';

class PressableContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final BoxConstraints? constraints;

  static const defaultBorderRadius = BorderRadius.all(Radius.circular(
    AppDimensions.borderRadiusMedium,
  ));

  const PressableContainer({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.margin,
    this.borderRadius = defaultBorderRadius,
    this.boxShadow,
    this.border,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
