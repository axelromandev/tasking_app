import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor, foregroundColor;
  final Widget child;
  final EdgeInsetsGeometry? margin, padding;
  final double? elevation;
  final TextStyle? textStyle;

  const CustomFilledButton({
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

    final backgroundColor = isDarkMode ? Colors.white : Colors.black;
    final foregroundColor = isDarkMode ? Colors.black : Colors.white;

    final style = FilledButton.styleFrom(
      elevation: elevation ?? 0,
      textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      backgroundColor: this.backgroundColor ?? backgroundColor,
      foregroundColor: this.foregroundColor ?? foregroundColor,
    );

    if (icon != null) {
      return Container(
        height: 56,
        width: double.infinity,
        margin: margin,
        padding: padding,
        child: FilledButton.icon(
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
      child: FilledButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
