import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: backgroundColor ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusL),
        elevation: elevation ?? 0,
        shadowColor: AppColors.shadowLight,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusL),
          child: Container(
            padding: padding ?? AppConstants.cardPadding,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusL),
              border: border,
              boxShadow: elevation != null ? AppConstants.shadowLight : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
