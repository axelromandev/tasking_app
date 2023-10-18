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
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // IconTheme
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.white),
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      centerTitle: true,
    ),

    // Card
    cardTheme: CardTheme(
      color: cardBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),

    // FilledButton
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        backgroundColor: cardBackgroundColor,
        foregroundColor: Colors.white,
      ),
    ),

    // DialogTheme
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0,
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),

    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBackgroundColor,
      contentPadding: const EdgeInsets.all(defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
    ),

    // listTileTheme
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
  );
});
