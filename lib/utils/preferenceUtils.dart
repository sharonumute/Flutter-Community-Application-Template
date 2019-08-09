import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const isDarkTheme_key = "SERVICE_APP_USER_THEME";
const tab_key = "SERVICE_APP_USER_CURRENT_TAB";

Future<bool> getIsOnDarkTheme() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(isDarkTheme_key) ?? false;
}

setStoreSelectedTheme(bool newValue) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(isDarkTheme_key, newValue);
}
