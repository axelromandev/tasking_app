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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
