import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'theme_constants.dart';

/// The app theme.
final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: AppColors.gray3,
  colorScheme: _getColorScheme(),
  textTheme: _getTextTheme(),
  textSelectionTheme: _getTextSelectionThemeData(),
  fontFamily: ThemeConstants.fontFamilyMontserrat,
  iconTheme: _getIconThemeData(),
  appBarTheme: _getAppBarTheme(),
);

IconThemeData _getIconThemeData() {
  return const IconThemeData(
    color: AppColors.primary,
    size: 18.0,
  );
}

AppBarTheme _getAppBarTheme() {
  return const AppBarTheme(
    backgroundColor: AppColors.white,
  );
}

ColorScheme _getColorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.black,
    secondary: AppColors.primary,
    onSecondary: AppColors.black,
    error: AppColors.primary,
    onError: AppColors.primary,
    background: AppColors.white,
    onBackground: AppColors.primary,
    surface: AppColors.accent,
    onSurface: AppColors.accent,
  );
}

TextSelectionThemeData _getTextSelectionThemeData() {
  return TextSelectionThemeData(
    cursorColor: AppColors.black.withOpacity(0.1),
  );
}

TextTheme _getTextTheme() {
  return const TextTheme(
    bodyText1: TextStyle(
      color: AppColors.black,
      fontSize: ThemeConstants.fontSize18,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      color: AppColors.bodyTypographyColor,
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.normal,
    ),
    caption: TextStyle(
      fontSize: ThemeConstants.fontSize12,
      fontWeight: FontWeight.normal,
    ),
    headline1: TextStyle(
      color: AppColors.black,
      fontSize: ThemeConstants.fontSize62,
      fontWeight: FontWeight.normal,
    ),
    headline2: TextStyle(
      color: AppColors.black,
      fontSize: ThemeConstants.fontSize36,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: ThemeConstants.fontSize20,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: AppColors.white,
      fontSize: ThemeConstants.fontSize18,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      color: AppColors.black,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.normal,
    ),
  );
}
