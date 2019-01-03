library service_app.themes;

import 'package:flutter/material.dart';
import './globals.dart' as globals;

ThemeData lightTheme = ThemeData(
  accentColor: globals.themeLightPrimary,
  accentIconTheme: IconThemeData(
    color: globals.normalWhiteText,
    size: globals.iconSize,
  ),
  accentTextTheme: TextTheme(
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalWhiteText,
    ),
  ),
  backgroundColor: globals.themeLightBackground,
  cardColor: globals.themeLightBackground,
  colorScheme: ColorScheme(
      primary: globals.themeLightPrimary,
      surface: globals.themeLightBackground,
      background: globals.themeLightBackground,
      brightness: Brightness.light,
      error: globals.errorRedText,
      onBackground: globals.mediumBlackText,
      onError: globals.normalWhiteText,
      onPrimary: globals.normalWhiteText,
      onSecondary: globals.normalWhiteText,
      onSurface: globals.mediumBlackText,
      primaryVariant: globals.themeLightPrimaryDark,
      secondary: globals.themeLightPrimary,
      secondaryVariant: globals.themeLightPrimaryDark),
  cursorColor: globals.normalBlackText,
  disabledColor: globals.disabledBlackText,
  dividerColor: globals.mediumBlackText,
  errorColor: globals.errorRedText,
  iconTheme: IconThemeData(
    color: globals.mediumBlackText,
    size: globals.iconSize,
  ),
  primaryColor: globals.themeLightPrimary,
  primaryIconTheme: IconThemeData(
    color: globals.normalWhiteText,
    size: globals.iconSize,
  ),
  primaryTextTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    title: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    display1: TextStyle(
      fontSize: 34.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    subhead: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
  ),
  scaffoldBackgroundColor: globals.themeLightBackground,
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalBlackText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      foreground: Paint()..color = globals.themeLightPrimary,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.normalBlackText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.mediumBlackText,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.helperBlackText,
    ),
  ),
  primaryColorDark: globals.themeLightPrimaryDark,
  primaryColorLight: globals.themeLightPrimaryLight,
  primaryColorBrightness: Brightness.light,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
);

ThemeData darkTheme = ThemeData(
  accentColor: globals.themeLightPrimary,
  accentIconTheme: IconThemeData(
    color: globals.normalWhiteText,
    size: globals.iconSize,
  ),
  accentTextTheme: TextTheme(
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalWhiteText,
    ),
  ),
  backgroundColor: globals.themeBlackBackground,
  cardColor: globals.themeBlackPrimary,
  colorScheme: ColorScheme(
      primary: globals.themeBlackPrimary,
      surface: globals.themeBlackBackground,
      background: globals.themeBlackBackground,
      brightness: Brightness.dark,
      error: globals.errorRedText,
      onBackground: globals.normalWhiteText,
      onError: globals.normalWhiteText,
      onPrimary: globals.normalWhiteText,
      onSecondary: globals.normalWhiteText,
      onSurface: globals.normalWhiteText,
      primaryVariant: globals.themeBlackPrimaryDark,
      secondary: globals.themeBlackPrimary,
      secondaryVariant: globals.themeBlackPrimaryDark),
  cursorColor: globals.normalWhiteText,
  disabledColor: globals.disabledWhiteText,
  dividerColor: globals.mediumWhiteText,
  errorColor: globals.errorRedText,
  iconTheme: IconThemeData(
    color: globals.normalWhiteText,
    size: globals.iconSize,
  ),
  primaryColor: globals.themeBlackPrimary,
  primaryIconTheme: IconThemeData(
    color: globals.normalWhiteText,
    size: globals.iconSize,
  ),
  primaryTextTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.normalWhiteText,
    ),
    display1: TextStyle(
      fontSize: 34.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    subhead: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
  ),
  scaffoldBackgroundColor: globals.themeBlackBackground,
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      color: globals.normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.boldTextWeight,
      foreground: Paint()..color = globals.normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.mediumWhiteText,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      fontWeight: globals.normalTextWeight,
      color: globals.helperWhiteText,
    ),
  ),
  primaryColorDark: globals.themeBlackPrimaryDark,
  primaryColorLight: globals.themeBlackPrimaryLight,
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: globals.themeLightPrimary,
  ),
);
