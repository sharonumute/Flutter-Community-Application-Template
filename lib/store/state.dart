import 'package:meta/meta.dart';
import 'package:service_application/utils/widgetUtils.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<SermonObject> sermons;
  final List<Event> events;
  final Map<DateTime, List<Event>> calendarEvents;
  final String currentSelectedCalendarDate;
  final bool isOnDarkTheme;

  AppState(
      {this.isLoading = false,
      this.sermons = const [],
      this.events = const [],
      this.calendarEvents = const {},
      this.currentSelectedCalendarDate = "",
      this.isOnDarkTheme = true});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<SermonObject> sermons,
    List<Event> events,
    Map<DateTime, List<Event>> calendarEvents,
    String currentSelectedCalendarDate,
    bool isOnDarkTheme,
  }) {
    return AppState(
        isLoading: isLoading ?? this.isLoading,
        sermons: sermons ?? this.sermons,
        events: events ?? this.events,
        calendarEvents: calendarEvents ?? this.calendarEvents,
        currentSelectedCalendarDate:
            currentSelectedCalendarDate ?? this.currentSelectedCalendarDate,
        isOnDarkTheme: isOnDarkTheme ?? this.isOnDarkTheme);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      sermons.hashCode ^
      events.hashCode ^
      calendarEvents.hashCode ^
      currentSelectedCalendarDate.hashCode ^
      isOnDarkTheme.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          sermons == other.sermons &&
          events == other.events &&
          calendarEvents == other.calendarEvents &&
          currentSelectedCalendarDate == other.currentSelectedCalendarDate &&
          isOnDarkTheme == other.isOnDarkTheme;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, sermons: $sermons, events: $events, calendarEvents: $calendarEvents, currentSelectedCalendarDate: $currentSelectedCalendarDate, isOnDarkTheme: $isOnDarkTheme}';
  }
}
