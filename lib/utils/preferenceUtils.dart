import 'dart:async';
import "package:community_application/Globals/Themes.dart";
import 'package:shared_preferences/shared_preferences.dart';

const THEME_KEY = "SERVICE_APP_USER_THEME";

Future<String> getCurrentTheme() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(THEME_KEY) ?? LIGHT_BLUE;
}

setSelectedTheme(String newValue) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(THEME_KEY, newValue);
}
