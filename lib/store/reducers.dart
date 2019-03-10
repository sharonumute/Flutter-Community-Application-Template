import "package:service_application/store/state.dart";
import 'package:service_application/store/actions.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/utils/stringUtils.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    sermons: sermonsReducer(state.sermons, action),
    events: eventsReducer(state.events, action),
    calendarEvents: calendarEventsReducer(state.calendarEvents, action),
    currentPage: pageReducer(state.currentPage, action),
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
    print("sermons fetched and loaded: ${sermonObjects.length}");
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
    print("events fetched and loaded: ${eventObjects.length}");
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

      if (startDate != null && !ifEmptyOrNull(startDate.toString())) {
        DateTime eventRegisterDate =
            new DateTime(startDate.year, startDate.month, startDate.day);

        if (calendarEventObjects[eventRegisterDate] == null) {
          calendarEventObjects[eventRegisterDate] = new List<Event>();
        }
        calendarEventObjects[eventRegisterDate].add(eventObject);
      }
    }

    action.store.dispatch(new CalendarEventsLoadedAction(calendarEventObjects));
    print("calendar events fetched and loaded: ${calendarEventObjects.length}");
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

final pageReducer = combineReducers<String>([
  TypedReducer<String, ChangePageAction>(setCurrentPage),
]);

String setCurrentPage(String state, ChangePageAction action) {
  return action.page;
}
