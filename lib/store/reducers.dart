import "package:service_application/store/state.dart";
import 'package:service_application/store/actions.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    sermons: sermonsReducer(state.sermons, action),
    events: eventsReducer(state.events, action),
    currentPage: pageReducer(state.currentPage, action),
  );
}

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, SermonsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, EventsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, FetchSermonsAction>(_setLoadedTrue),
  TypedReducer<bool, FetchEventsAction>(_fetchEvents),
]);

bool _setLoadedFalse(bool state, action) {
  return false;
}

bool _setLoadedTrue(bool state, action) {
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
    print("events produced: ${eventObjects.length}");
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
