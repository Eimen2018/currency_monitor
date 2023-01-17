import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: kcBackgroundColor,
  primaryColor: kcPrimaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kcPrimaryColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: kcWhite,
    ),
    iconTheme: IconThemeData(
      color: kcWhite,
      size: 18,
    ),
  ),
  dividerColor: kcBackgroundColor,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: kcPrimaryColor,
    selectionColor: kcPrimaryColor.withOpacity(0.8),
    selectionHandleColor: kcPrimaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kcPrimaryColor,
    foregroundColor: Colors.white,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: kcMediumGrey,
    textColor: kcVeryLightGrey,
    iconColor: kcPrimaryColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 40),
    selectedTileColor: kcPrimaryColor.withOpacity(0.8),
    selectedColor: kcWhite,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kcMediumGrey,
    hintStyle: const TextStyle(color: kcVeryLightGrey),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    floatingLabelStyle: const TextStyle(color: kcVeryLightGrey),
    focusColor: kcPrimaryColor,
    iconColor: kcPrimaryColor,
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none,
    ),
  ),
);
