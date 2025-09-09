import 'package:flutter/material.dart';

import '../cores.dart';
import 'app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final String? title;
  final Function()? onPressed;
  final Widget? child;
  final bool? loading;
  final MainAxisAlignment? mainAxisAlignment;
  final FontWeight? textFontWeight;
  final Color? color,
      hoverColor,
      disableTextColor,
      disableColor,
      borderColor,
      loaderColor,
      textColor;
  final double? elevation,
      disableElevation,
      radius,
      borderWidth,
      height,
      width,
      fontSize;
  final BorderStyle? borderStyle;
  final bool wrap;
  const AppButton({
    super.key,
    this.onPressed,
    this.child,
    this.color,
    this.elevation,
    this.hoverColor,
    this.disableTextColor,
    this.disableColor,
    this.disableElevation,
    this.radius,
    this.padding,
    this.margin,
    this.loading,
    this.mainAxisAlignment,
    this.borderColor,
    this.borderWidth,
    this.borderStyle,
    this.height,
    this.width,
    this.title,
    this.textColor,
    this.wrap = false,
    this.loaderColor,
    this.fontSize,
    this.textFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (wrap ? null : double.infinity),
      margin: margin,
      child: MaterialButton(
        highlightElevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        shape: RoundedRectangleBorder(
          side: borderWidth == null
              ? BorderSide.none
              : BorderSide(
                  width: borderWidth ?? 0,
                  color: borderColor ?? AppColors.primaryColor,
                  style: borderStyle ?? BorderStyle.solid,
                ),
          borderRadius: BorderRadius.circular(radius ?? 5),
        ),
        color: color ?? AppColors.primaryColor,
        elevation: elevation ?? 0,
        minWidth: 0,
        height: height ?? 56,
        hoverColor: hoverColor,
        disabledColor: disableColor ?? AppColors.primaryColor.withOpacity(0.5),
        disabledTextColor: disableTextColor ?? Colors.white,
        disabledElevation: disableElevation,
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child:
            child ??
            Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  title ?? '',
                  fontWeight: textFontWeight ?? FontWeight.w500,
                  fontSize: fontSize ?? 18,
                  color: textColor ?? Colors.white,
                  fontFamily: 'BricolageGrotesque',
                ),
                if (loading ?? false)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: AppCircularProgressIndicator(
                      size: 20,
                      color: textColor ?? Colors.white,
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}
