import 'package:flutter/material.dart';
import 'package:tasking/config/config.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor, foregroundColor;
  final Widget child;
  final EdgeInsetsGeometry? margin, padding;
  final double? elevation;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.margin,
    this.padding,
    this.elevation,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final color = isDarkMode ? Colors.white : Colors.black;

    final style = OutlinedButton.styleFrom(
      elevation: elevation ?? 0,
      textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        side: BorderSide(color: foregroundColor ?? color, width: 2),
      ),
      foregroundColor: foregroundColor ?? color,
    );

    if (icon != null) {
      return Container(
        height: 56,
        width: double.infinity,
        margin: margin,
        padding: padding,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon!,
          style: style,
          label: child,
        ),
      );
    }

    return Container(
      height: 56,
      width: double.infinity,
      margin: margin,
      padding: padding,
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
