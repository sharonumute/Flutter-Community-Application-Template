import 'package:service_application/Utils/DataUtils.dart';
import "package:service_application/Store/State.dart";

List<Sermon> sermonsSelector(AppState state) => state.sermons;
List<Event> eventsSelector(AppState state) => state.events;
List<DatetimeObject> feedSelector(AppState state) => state.feed;
String currentSelectedCalendarDateSelector(AppState state) =>
    state.currentSelectedCalendarDate;
String currentThemeSelector(AppState state) => state.currentTheme;
