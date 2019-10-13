library service_app.themes;

import 'package:flutter/material.dart';
import 'package:community_application/Globals/Values.dart';

const LIGHT_BLUE = "LIGHTBLUE";
const DARK_BLUE = "DARKBLUE";
const DARK_BLACK = "DARKBLACK";

const LIGHT_THEMES = const [LIGHT_BLUE];
const DARK_THEMES = const [DARK_BLUE, DARK_BLACK];

Map<String, ThemeData> allThemes = {
  DARK_BLACK: darkThemeBlackHue,
  DARK_BLUE: darkThemeBlueHue,
  LIGHT_BLUE: lightBlueTheme
};

ThemeData lightBlueTheme = ThemeData(
  accentColor: themeLightBluePrimary,
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
  backgroundColor: themeLightBlueAppBackground,
  cardColor: themeLightBlueBackground,
  colorScheme: ColorScheme(
      primary: themeLightBluePrimary,
      surface: themeLightBlueBackground,
      background: themeLightBlueAppBackground,
      brightness: Brightness.light,
      error: errorRedText,
      onBackground: mediumBlackText,
      onError: normalWhiteText,
      onPrimary: normalWhiteText,
      onSecondary: normalWhiteText,
      onSurface: mediumBlackText,
      primaryVariant: themeLightBluePrimaryDark,
      secondary: themeLightBluePrimary,
      secondaryVariant: themeLightBluePrimaryDark),
  cursorColor: normalBlackText,
  disabledColor: disabledBlackText,
  dividerColor: mediumBlackText,
  errorColor: errorRedText,
  iconTheme: IconThemeData(
    color: mediumBlackText,
    size: iconSize,
  ),
  primaryColor: themeLightBluePrimary,
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
  scaffoldBackgroundColor: themeLightBlueAppBackground,
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
      foreground: Paint()..color = themeLightBluePrimary,
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
  primaryColorDark: themeLightBluePrimaryDark,
  primaryColorLight: themeLightBluePrimaryLight,
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

ThemeData darkThemeBlackHue = ThemeData(
  accentColor: themeDarkBlackAccent,
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
  backgroundColor: themeDarkBlackBackground,
  cardColor: themeDarkBlackPrimary,
  colorScheme: ColorScheme(
      primary: themeDarkBlackPrimary,
      surface: themeDarkBlackBackground,
      background: themeDarkBlackBackground,
      brightness: Brightness.dark,
      error: errorRedText,
      onBackground: normalWhiteText,
      onError: normalWhiteText,
      onPrimary: normalWhiteText,
      onSecondary: normalWhiteText,
      onSurface: normalWhiteText,
      primaryVariant: themeDarkBlackPrimaryDark,
      secondary: themeDarkBlackPrimary,
      secondaryVariant: themeDarkBlackPrimaryDark),
  cursorColor: normalWhiteText,
  disabledColor: disabledWhiteText,
  dividerColor: mediumWhiteText,
  errorColor: errorRedText,
  iconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  primaryColor: themeDarkBlackPrimary,
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
  scaffoldBackgroundColor: themeDarkBlackBackground,
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
  primaryColorDark: themeDarkBlackPrimaryDark,
  primaryColorLight: themeDarkBlackPrimaryLight,
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: themeDarkBlackAccent,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(255, 255, 255, 1.0),
    unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
  ),
);

ThemeData darkThemeBlueHue = ThemeData(
  accentColor: themeDarkBlueAccent,
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
  backgroundColor: themeDarkBlueBackground,
  cardColor: themeDarkBluePrimary,
  colorScheme: ColorScheme(
      primary: themeDarkBluePrimary,
      surface: themeDarkBlueBackground,
      background: themeDarkBlueBackground,
      brightness: Brightness.dark,
      error: errorRedText,
      onBackground: normalWhiteText,
      onError: normalWhiteText,
      onPrimary: normalWhiteText,
      onSecondary: normalWhiteText,
      onSurface: normalWhiteText,
      primaryVariant: themeDarkBluePrimaryDark,
      secondary: themeDarkBluePrimary,
      secondaryVariant: themeDarkBluePrimaryDark),
  cursorColor: normalWhiteText,
  disabledColor: disabledWhiteText,
  dividerColor: mediumWhiteText,
  errorColor: errorRedText,
  iconTheme: IconThemeData(
    color: normalWhiteText,
    size: iconSize,
  ),
  primaryColor: themeDarkBluePrimary,
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
  scaffoldBackgroundColor: themeDarkBlueBackground,
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
  primaryColorDark: themeDarkBluePrimaryDark,
  primaryColorLight: themeDarkBluePrimaryLight,
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: themeDarkBlueAccent,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(255, 255, 255, 1.0),
    unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
  ),
);
