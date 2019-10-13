import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Models/DateTimeObject.dart';
import "package:community_application/Store/State.dart";

List<Article> articlesSelector(AppState state) => state.articles;
List<Event> eventsSelector(AppState state) => state.events;
List<DatetimeObject> feedSelector(AppState state) => state.feed;
String currentSelectedCalendarDateSelector(AppState state) =>
    state.currentSelectedCalendarDate;
String currentThemeSelector(AppState state) => state.currentTheme;
