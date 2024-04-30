import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: elevation,
      focusElevation: elevation,
      hoverElevation: elevation,
      highlightElevation: elevation,
      disabledElevation: elevation,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
