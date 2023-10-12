import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    // General
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.jua().fontFamily,
    colorSchemeSeed: primaryColorCode,
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    // PageTransitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),

    // IconTheme
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      centerTitle: true,
    ),

    // Card
    cardTheme: const CardTheme(
      color: cardBackgroundColor,
      elevation: 0,
    ),

    // FilledButton
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: cardBackgroundColor,
        foregroundColor: Colors.white,
      ),
    ),

    // DialogTheme
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0,
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),

    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBackgroundColor,
      contentPadding: const EdgeInsets.all(defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
        borderSide: BorderSide.none,
      ),
    ),
  );
});
