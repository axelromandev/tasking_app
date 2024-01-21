import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasking/config/config.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  final isDarkMode = ref.watch(changeThemeProvider);

  return ThemeData(
    // General
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    fontFamily: GoogleFonts.lexend().fontFamily,
    colorSchemeSeed: isDarkMode ? Colors.white : Colors.black,
    scaffoldBackgroundColor:
        isDarkMode ? backgroundDarkColor : backgroundLightColor,

    // PageTransitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // IconTheme
    iconTheme: IconThemeData(
      color: isDarkMode ? Colors.white : Colors.black,
    ),
    primaryIconTheme: IconThemeData(
      color: isDarkMode ? Colors.white : Colors.black,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkMode ? backgroundDarkColor : backgroundLightColor,
      centerTitle: true,
    ),

    // Card
    cardTheme: CardTheme(
      color: isDarkMode ? cardDarkColor : cardLightColor,
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
        backgroundColor: isDarkMode ? cardDarkColor : cardLightColor,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
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
      backgroundColor: isDarkMode ? backgroundDarkColor : backgroundLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0,
      backgroundColor: isDarkMode ? backgroundDarkColor : backgroundLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),

    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDarkMode ? cardDarkColor : cardLightColor,
      contentPadding: const EdgeInsets.all(defaultPadding),
      iconColor: isDarkMode ? Colors.white : Colors.black,
      hintStyle: TextStyle(
        color: isDarkMode ? Colors.white70 : Colors.black54,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
    ),

    // listTileTheme
    listTileTheme: ListTileThemeData(
      iconColor: isDarkMode ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
  );
});
