import 'package:flutter/material.dart';
import 'package:community_application/Pages/SettingsPage.dart';
import 'package:community_application/Pages/AboutPage.dart';

const SETTINGS_PAGE = '/settings';
const ABOUT_PAGE = '/about';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  SETTINGS_PAGE: (BuildContext context) => new SettingsPageContainer(),
  ABOUT_PAGE: (BuildContext context) => new AboutPageContainer(),
};
