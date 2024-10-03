import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';

class CustomFilledButton extends ConsumerWidget {
  const CustomFilledButton({
    required this.onPressed,
    required this.child,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.margin,
    this.padding,
    this.elevation,
    this.height,
    this.width,
    this.textStyle,
    this.side,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final BorderSide? side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.watch(colorThemeProvider);

    final style = FilledButton.styleFrom(
      elevation: elevation ?? 0,
      textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      backgroundColor: backgroundColor ?? colorProvider,
      foregroundColor: foregroundColor ??
          AppColors.getTextColor(backgroundColor ?? colorProvider),
      side: side,
    );

    if (icon != null) {
      return Container(
        height: 56,
        width: width,
        margin: margin,
        padding: padding,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon,
          style: style,
          label: child,
        ),
      );
    }

    return Container(
      height: height,
      width: width,
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
