import "package:service_application/store/state.dart";
import 'package:service_application/store/actions.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/utils/stringUtils.dart';
import 'package:service_application/utils/dateUtils.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    sermons: sermonsReducer(state.sermons, action),
    events: eventsReducer(state.events, action),
    calendarEvents: calendarEventsReducer(state.calendarEvents, action),
    currentSelectedCalendarDate: currentSelectedCalendarDateReducer(
        state.currentSelectedCalendarDate, action),
  );
}

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, SermonsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, EventsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, CalendarEventsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, FetchSermonsAction>(_fetchSermons),
  TypedReducer<bool, FetchEventsAction>(_fetchEvents),
  TypedReducer<bool, FetchCalendarEventsAction>(_fetchCalendarEvents),
]);

bool _setLoadedFalse(bool state, action) {
  return false;
}

bool _fetchSermons(bool state, FetchSermonsAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final sermons = json.decode(data)["Sermons"];

    List<SermonObject> sermonObjects = [];
    for (Map<String, dynamic> sermon in sermons) {
      SermonObject sermonObject = SermonObject.fromJson(sermon);
      sermonObjects.add(sermonObject);
    }

    action.store.dispatch(new SermonsLoadedAction(sermonObjects));
    print("Sermons fetched and loaded: ${sermonObjects.length}");
  });

  return true;
}

bool _fetchEvents(bool state, FetchEventsAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final events = json.decode(data)["Events"];

    List<Event> eventObjects = [];
    for (Map<String, dynamic> event in events) {
      Event eventObject = Event.fromJson(event);
      eventObjects.add(eventObject);
    }

    action.store.dispatch(new EventsLoadedAction(eventObjects));
    print("Events fetched and loaded: ${eventObjects.length}");
  });

  return true;
}

bool _fetchCalendarEvents(bool state, FetchCalendarEventsAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final calendarEvents = json.decode(data)["Events"];

    Map<DateTime, List<Event>> calendarEventObjects = {};
    for (Map<String, dynamic> event in calendarEvents) {
      Event eventObject = Event.fromJson(event);

      DateTime startDate = eventObject.startDate;
      DateTime endDate = eventObject.endDate;

      if (startDate != null &&
          endDate != null &&
          !ifEmptyOrNull(startDate.toString()) &&
          !ifEmptyOrNull(endDate.toString())) {
        DateTime eventStartDate =
            new DateTime(startDate.year, startDate.month, startDate.day);

        DateTime eventEndDate =
            new DateTime(endDate.year, endDate.month, endDate.day);

        for (DateTime eventDay in onlyDaysInRange(
            eventStartDate, eventEndDate.add(Duration(days: 1)))) {
          if (calendarEventObjects[eventDay] == null) {
            calendarEventObjects[eventDay] = new List<Event>();
          }
          calendarEventObjects[eventDay].add(eventObject);
        }
      }
    }

    action.store.dispatch(new CalendarEventsLoadedAction(calendarEventObjects));
    print("Calendar events fetched and loaded: ${calendarEventObjects.length}");
  });

  return true;
}

final sermonsReducer = combineReducers<List<SermonObject>>([
  TypedReducer<List<SermonObject>, SermonsLoadedAction>(loadSermonsIntoApp),
]);

List<SermonObject> loadSermonsIntoApp(
    List<SermonObject> state, SermonsLoadedAction action) {
  return action.sermons;
}

final calendarEventsReducer = combineReducers<Map<DateTime, List<Event>>>([
  TypedReducer<Map<DateTime, List<Event>>, CalendarEventsLoadedAction>(
      loadCalendarEventsIntoApp),
]);

Map<DateTime, List<Event>> loadCalendarEventsIntoApp(
    Map<DateTime, List<Event>> state, CalendarEventsLoadedAction action) {
  return action.calendarEvents;
}

final eventsReducer = combineReducers<List<Event>>([
  TypedReducer<List<Event>, EventsLoadedAction>(loadEventsIntoApp),
]);

List<Event> loadEventsIntoApp(List<Event> state, EventsLoadedAction action) {
  return action.events;
}

final currentSelectedCalendarDateReducer = combineReducers<String>([
  TypedReducer<String, SetCurrentSelectedCalendarAction>(
      setCurrentSelectedCalendarDate),
]);

String setCurrentSelectedCalendarDate(
    String state, SetCurrentSelectedCalendarAction action) {
  print("Calendar selected date set to: ${action.date}");
  return action.date;
}
