import 'package:meta/meta.dart';
import "package:community_application/Globals/Themes.dart";
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Models/DateTimeObject.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Article> articles;
  final List<Event> events;
  final List<DatetimeObject> feed;
  final String currentSelectedCalendarDate;
  final String currentTheme;

  AppState(
      {this.isLoading = false,
      this.articles = const [],
      this.events = const [],
      this.feed = const [],
      this.currentSelectedCalendarDate = "",
      this.currentTheme = LIGHT_BLUE});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Article> articles,
    List<Event> events,
    List<DatetimeObject> feed,
    String currentSelectedCalendarDate,
    String currentTheme,
  }) {
    return AppState(
        isLoading: isLoading ?? this.isLoading,
        articles: articles ?? this.articles,
        events: events ?? this.events,
        feed: feed ?? this.feed,
        currentSelectedCalendarDate:
            currentSelectedCalendarDate ?? this.currentSelectedCalendarDate,
        currentTheme: currentTheme ?? this.currentTheme);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      articles.hashCode ^
      events.hashCode ^
      feed.hashCode ^
      currentSelectedCalendarDate.hashCode ^
      currentTheme.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          articles == other.articles &&
          events == other.events &&
          feed == other.feed &&
          currentSelectedCalendarDate == other.currentSelectedCalendarDate &&
          currentTheme == other.currentTheme;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, articles: $articles, events: $events, feed: $feed, currentSelectedCalendarDate: $currentSelectedCalendarDate, currentTheme: $currentTheme}';
  }
}
