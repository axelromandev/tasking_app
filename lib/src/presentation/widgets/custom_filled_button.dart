import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor, foregroundColor;
  final Widget child;
  final EdgeInsetsGeometry? margin, padding;
  final double? elevation, height;
  final TextStyle? textStyle;
  final BorderSide? side;

  const CustomFilledButton({
    required this.onPressed,
    required this.child,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.margin,
    this.padding,
    this.elevation,
    this.height = 56,
    this.textStyle,
    this.side,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final style = FilledButton.styleFrom(
      elevation: elevation ?? 0,
      textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      backgroundColor: backgroundColor ?? colors.primary,
      foregroundColor: foregroundColor,
      side: side,
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
      height: height,
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
