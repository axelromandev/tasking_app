import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/logo_icon.svg',
          height: 40,
        ),
        const SizedBox(height: 16),
        SvgPicture.asset(
          'assets/svg/logo_text.svg',
          width: 200,
        ),
      ],
    );
  }
}
