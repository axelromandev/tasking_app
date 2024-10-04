import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  final colorSeed = ref.watch(colorThemeProvider);

  return ThemeData(
    // General
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Lexend',
    colorSchemeSeed: colorSeed,
    scaffoldBackgroundColor: AppColors.background,

    // PageTransitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // TextTheme
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),

    // DividerThemeData
    dividerTheme: const DividerThemeData(
      color: Colors.white12,
      space: defaultPadding,
      thickness: 1,
    ),

    // IconTheme
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.white),
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    // Card
    cardTheme: CardTheme(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),

    // FilledButton
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        backgroundColor: colorSeed,
        foregroundColor: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
      ),
    ),

    // DialogTheme
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: AppColors.background,
      insetPadding: const EdgeInsets.all(defaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(),
    ),

    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.all(defaultPadding),
      iconColor: Colors.white,
      hintStyle: const TextStyle(
        color: Colors.white70,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
        borderSide: BorderSide.none,
      ),
    ),

    dividerColor: Colors.white12,

    // ProgressIndicatorThemeData
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorSeed,
    ),

    // listTileTheme
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),

    // floatingActionButtonTheme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorSeed,
      foregroundColor: Colors.black,
    ),

    // drawerThemeData
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(defaultPadding),
          bottomRight: Radius.circular(defaultPadding),
        ),
      ),
    ),
  );
});
