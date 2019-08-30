import "package:service_application/Store/State.dart";
import 'package:service_application/Store/Actions.dart';
import 'package:service_application/Utils/PreferenceUtils.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    currentTheme: currentThemeReducer(state.currentTheme, action),
    currentSelectedCalendarDate: currentSelectedCalendarDateReducer(
        state.currentSelectedCalendarDate, action),
    sermons: sermonsReducer(state.sermons, action),
    events: eventsReducer(state.events, action),
    feed: feedReducer(state.feed, action),
  );
}

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, FetchSermonsAction>(_fetchSermons),
  TypedReducer<bool, FetchEventsAction>(_fetchEvents),
  TypedReducer<bool, SermonsLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, EventsLoadedAction>(_setLoadedFalse),
]);

final sermonsReducer = combineReducers<List<Sermon>>([
  TypedReducer<List<Sermon>, SermonsLoadedAction>(addSermonsIntoApp),
]);

final eventsReducer = combineReducers<List<Event>>([
  TypedReducer<List<Event>, EventsLoadedAction>(addEventsIntoApp),
]);

final feedReducer = combineReducers<List<DatetimeObject>>([
  TypedReducer<List<DatetimeObject>, FeedLoadedAction>(addFeedIntoApp),
]);

final currentSelectedCalendarDateReducer = combineReducers<String>([
  TypedReducer<String, SetCurrentSelectedCalendarDateAction>(
      setCurrentSelectedCalendarDate),
]);

final currentThemeReducer = combineReducers<String>([
  TypedReducer<String, ChangeThemesAction>(setSelectedThemeState),
]);

bool _setLoadedFalse(bool state, action) {
  return false;
}

bool _fetchSermons(bool state, FetchSermonsAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final sermons = json.decode(data)["Sermons"];

    List<Sermon> sermonObjects = [];
    for (Map<String, dynamic> sermon in sermons) {
      Sermon sermonObject = Sermon.fromJson(sermon);
      sermonObjects.add(sermonObject);
    }

    action.store.dispatch(new SermonsLoadedAction(sermonObjects));
    action.store.dispatch(new FeedLoadedAction(sermonObjects));
    print("Sermons fetched and loaded: ${sermonObjects.length}");
  });

  return true;
}

List<Sermon> addSermonsIntoApp(List<Sermon> state, SermonsLoadedAction action) {
  List<Sermon> newSermons = [];
  newSermons.addAll(state);
  newSermons.addAll(action.sermons);
  return newSermons;
}

bool _fetchEvents(bool state, FetchEventsAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final events = json.decode(data)["Events"];

    List<Event> eventObjects = [];
    for (Map<String, dynamic> event in events) {
      List<Event> individualEvents = createEventsFrom(event);
      eventObjects.addAll(individualEvents);
    }

    action.store.dispatch(new EventsLoadedAction(eventObjects));
    action.store.dispatch(new FeedLoadedAction(eventObjects));
    print("Events fetched and loaded: ${eventObjects.length}");
  });

  return true;
}

List<Event> addEventsIntoApp(List<Event> state, EventsLoadedAction action) {
  List<Event> newEvents = [];
  newEvents.addAll(state);
  newEvents.addAll(action.events);
  return newEvents;
}

String setCurrentSelectedCalendarDate(
    String state, SetCurrentSelectedCalendarDateAction action) {
  print("Calendar selected date set to: ${action.date}");
  return action.date;
}

String setSelectedThemeState(String state, ChangeThemesAction action) {
  print("New Theme: ${action.newTheme}");
  setSelectedTheme(action.newTheme);
  return action.newTheme;
}

List<DatetimeObject> addFeedIntoApp(
    List<DatetimeObject> state, FeedLoadedAction action) {
  List<DatetimeObject> newFeed = [];
  newFeed.addAll(state);
  newFeed.addAll(action.feed);
  return newFeed;
}
