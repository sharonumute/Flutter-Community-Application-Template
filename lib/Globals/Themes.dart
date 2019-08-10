library service_app.themes;

import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';

ThemeData lightTheme = ThemeData(
  accentColor: themeLightPrimary,
  accentIconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  accentTextTheme: TextTheme(
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
  ),
  backgroundColor: themeLightAppBackground,
  cardColor: themeLightBackground,
  colorScheme: ColorScheme(
      primary: themeLightPrimary,
      surface: themeLightBackground,
      background: themeLightAppBackground,
      brightness: Brightness.light,
      error: errorRedText,
      onBackground: mediumBlackText,
      onError: normalWhiteText,
      onPrimary: normalWhiteText,
      onSecondary: normalWhiteText,
      onSurface: mediumBlackText,
      primaryVariant: themeLightPrimaryDark,
      secondary: themeLightPrimary,
      secondaryVariant: themeLightPrimaryDark),
  cursorColor: normalBlackText,
  disabledColor: disabledBlackText,
  dividerColor: mediumBlackText,
  errorColor: errorRedText,
  iconTheme: IconThemeData(
    color: mediumBlackText,
    size: iconSize,
  ),
  primaryColor: themeLightPrimary,
  primaryIconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  primaryTextTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    title: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    display1: TextStyle(
      fontSize: 34.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    subhead: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
  ),
  scaffoldBackgroundColor: themeLightAppBackground,
  textTheme: TextTheme(
    display1: TextStyle(
      fontSize: 60.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalBlackText,
    ),
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalBlackText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      foreground: Paint()..color = themeLightPrimary,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: normalBlackText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: mediumBlackText,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: helperBlackText,
    ),
  ),
  primaryColorDark: themeLightPrimaryDark,
  primaryColorLight: themeLightPrimaryLight,
  primaryColorBrightness: Brightness.light,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(255, 255, 255, 1.0),
    unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
  ),
);

ThemeData darkTheme = ThemeData(
  accentColor: themeLightPrimary,
  accentIconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  accentTextTheme: TextTheme(
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
  ),
  backgroundColor: themeBlackBackground,
  cardColor: themeBlackPrimary,
  colorScheme: ColorScheme(
      primary: themeBlackPrimary,
      surface: themeBlackBackground,
      background: themeBlackBackground,
      brightness: Brightness.dark,
      error: errorRedText,
      onBackground: normalWhiteText,
      onError: normalWhiteText,
      onPrimary: normalWhiteText,
      onSecondary: normalWhiteText,
      onSurface: normalWhiteText,
      primaryVariant: themeBlackPrimaryDark,
      secondary: themeBlackPrimary,
      secondaryVariant: themeBlackPrimaryDark),
  cursorColor: normalWhiteText,
  disabledColor: disabledWhiteText,
  dividerColor: mediumWhiteText,
  errorColor: errorRedText,
  iconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  primaryColor: themeBlackPrimary,
  primaryIconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  primaryTextTheme: TextTheme(
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: normalWhiteText,
    ),
    display1: TextStyle(
      fontSize: 34.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    subhead: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
  ),
  scaffoldBackgroundColor: themeBlackBackground,
  textTheme: TextTheme(
    display1: TextStyle(
      fontSize: 60.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
    headline: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      color: normalWhiteText,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: boldTextWeight,
      foreground: Paint()..color = normalWhiteText,
    ),
    body1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: normalWhiteText,
    ),
    body2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: mediumWhiteText,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      fontWeight: normalTextWeight,
      color: helperWhiteText,
    ),
  ),
  primaryColorDark: themeBlackPrimaryDark,
  primaryColorLight: themeBlackPrimaryLight,
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: themeLightPrimary,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(255, 255, 255, 1.0),
    unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
  ),
);
