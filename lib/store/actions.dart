import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Models/DateTimeObject.dart';
import 'package:community_application/Store/State.dart';
import 'package:redux/redux.dart';

class FetchArticlesAction {
  final Store<AppState> store;

  FetchArticlesAction(this.store);

  @override
  String toString() {
    return 'Fetching articles...';
  }
}

class ArticlesLoadedAction {
  final List<Article> articles;

  ArticlesLoadedAction(this.articles);

  @override
  String toString() {
    return 'ArticlesLoadedAction{articles: $articles}';
  }
}

class ArticleSelectedAction {
  final Article article;

  ArticleSelectedAction(this.article);

  @override
  String toString() {
    return 'ArticleSelectedAction{article: $article}';
  }
}

class FetchEventsAction {
  final Store<AppState> store;

  FetchEventsAction(this.store);

  @override
  String toString() {
    return 'Fetching events...';
  }
}

class EventsLoadedAction {
  final List<Event> events;

  EventsLoadedAction(this.events);

  @override
  String toString() {
    return 'EventsLoadedAction{events: $events}';
  }
}

class EventSelectedAction {
  final Event event;

  EventSelectedAction(this.event);

  @override
  String toString() {
    return 'EventSelectedAction{event: $event}';
  }
}

class SetCurrentSelectedCalendarDateAction {
  final String date;

  SetCurrentSelectedCalendarDateAction(this.date);

  @override
  String toString() {
    return 'SetCurrentSelectedCalendarDateAction{date: $date}';
  }
}

class ChangeThemesAction {
  final String newTheme;

  ChangeThemesAction(this.newTheme);

  @override
  String toString() {
    return 'ChangeThemesAction{newTheme: $newTheme}';
  }
}

class FeedLoadedAction {
  final List<DatetimeObject> feed;

  FeedLoadedAction(this.feed);

  @override
  String toString() {
    return 'FeedLoadedAction{feed: $feed}';
  }
}
