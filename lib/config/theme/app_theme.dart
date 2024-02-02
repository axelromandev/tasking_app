import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasking/config/config.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  final colorSeed = ref.watch(colorThemeProvider);

  return ThemeData(
    // General
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.lexend().fontFamily,
    colorSchemeSeed: colorSeed,
    scaffoldBackgroundColor: MyColors.backgroundDark,

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

    primaryTextTheme: GoogleFonts.lexendTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.backgroundDark,
      centerTitle: true,
    ),

    // Card
    cardTheme: CardTheme(
      color: MyColors.cardDark,
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
        backgroundColor: colorSeed,
        foregroundColor: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    ),

    // DialogTheme
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: MyColors.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0,
      backgroundColor: MyColors.backgroundDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultRadius),
          topRight: Radius.circular(defaultRadius),
        ),
      ),
    ),

    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MyColors.cardDark,
      contentPadding: const EdgeInsets.all(defaultPadding),
      iconColor: Colors.white,
      hintStyle: const TextStyle(
        color: Colors.white70,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
    ),

    // listTileTheme
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorSeed,
      foregroundColor: Colors.black,
    ),
  );
});
