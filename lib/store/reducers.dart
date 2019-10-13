import "package:community_application/Store/State.dart";
import 'package:community_application/Store/Actions.dart';
import 'package:community_application/Utils/PreferenceUtils.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Models/DateTimeObject.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    currentTheme: currentThemeReducer(state.currentTheme, action),
    currentSelectedCalendarDate: currentSelectedCalendarDateReducer(
        state.currentSelectedCalendarDate, action),
    articles: articlesReducer(state.articles, action),
    events: eventsReducer(state.events, action),
    feed: feedReducer(state.feed, action),
  );
}

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, FetchArticlesAction>(_fetchArticles),
  TypedReducer<bool, FetchEventsAction>(_fetchEvents),
  TypedReducer<bool, ArticlesLoadedAction>(_setLoadedFalse),
  TypedReducer<bool, EventsLoadedAction>(_setLoadedFalse),
]);

final articlesReducer = combineReducers<List<Article>>([
  TypedReducer<List<Article>, ArticlesLoadedAction>(addArticlesIntoApp),
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

bool _fetchArticles(bool state, FetchArticlesAction action) {
  rootBundle.loadString("assets/test_data.json").then((data) {
    final articles = json.decode(data)["Articles"];

    List<Article> articleObjects = [];
    for (Map<String, dynamic> article in articles) {
      Article articleObject = Article.fromJson(article);
      articleObjects.add(articleObject);
    }

    action.store.dispatch(new ArticlesLoadedAction(articleObjects));
    action.store.dispatch(new FeedLoadedAction(articleObjects));
    print("Articles fetched and loaded: ${articleObjects.length}");
  });

  return true;
}

List<Article> addArticlesIntoApp(
    List<Article> state, ArticlesLoadedAction action) {
  List<Article> newArticles = [];
  newArticles.addAll(state);
  newArticles.addAll(action.articles);
  return newArticles;
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
