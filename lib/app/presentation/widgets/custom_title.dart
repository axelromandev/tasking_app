import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final Color? color;

  const CustomTitle(
    this.text, {
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Text(text,
        style: style.displaySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: color,
        ));
  }
}
