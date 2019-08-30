import 'package:meta/meta.dart';
import "package:service_application/Globals/Themes.dart";
import 'package:service_application/Utils/DataUtils.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Sermon> sermons;
  final List<Event> events;
  final List<DatetimeObject> feed;
  final String currentSelectedCalendarDate;
  final String currentTheme;

  AppState(
      {this.isLoading = false,
      this.sermons = const [],
      this.events = const [],
      this.feed = const [],
      this.currentSelectedCalendarDate = "",
      this.currentTheme = LIGHT_BLUE});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Sermon> sermons,
    List<Event> events,
    List<DatetimeObject> feed,
    String currentSelectedCalendarDate,
    String currentTheme,
  }) {
    return AppState(
        isLoading: isLoading ?? this.isLoading,
        sermons: sermons ?? this.sermons,
        events: events ?? this.events,
        feed: feed ?? this.feed,
        currentSelectedCalendarDate:
            currentSelectedCalendarDate ?? this.currentSelectedCalendarDate,
        currentTheme: currentTheme ?? this.currentTheme);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      sermons.hashCode ^
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
          sermons == other.sermons &&
          events == other.events &&
          feed == other.feed &&
          currentSelectedCalendarDate == other.currentSelectedCalendarDate &&
          currentTheme == other.currentTheme;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, sermons: $sermons, events: $events, feed: $feed, currentSelectedCalendarDate: $currentSelectedCalendarDate, currentTheme: $currentTheme}';
  }
}
