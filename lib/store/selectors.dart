import 'package:service_application/utils/widgetUtils.dart';
import "package:service_application/store/state.dart";

List<SermonObject> sermonsSelector(AppState state) => state.sermons;
List<Event> eventsSelector(AppState state) => state.events;
Map<DateTime, List<Event>> calendarEventsSelector(AppState state) =>
    state.calendarEvents;
String currentSelectedCalendarDateSelector(AppState state) =>
    state.currentSelectedCalendarDate;
