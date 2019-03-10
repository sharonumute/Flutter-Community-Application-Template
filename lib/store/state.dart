import 'package:meta/meta.dart';
import 'package:service_application/utils/widgetUtils.dart';
import "package:service_application/pages/pageController.dart"
    as PageController;

@immutable
class AppState {
  final bool isLoading;
  final List<SermonObject> sermons;
  final List<Event> events;
  final Map<DateTime, List<Event>> calendarEvents;
  final String currentPage;

  AppState({
    this.isLoading = false,
    this.sermons = const [],
    this.events = const [],
    this.calendarEvents = const {},
    this.currentPage = PageController.HOME_PAGE,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<SermonObject> sermons,
    List<Event> events,
    Map<DateTime, List<Event>> calendarEvents,
    String currentPage,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      sermons: sermons ?? this.sermons,
      events: events ?? this.events,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      sermons.hashCode ^
      events.hashCode ^
      calendarEvents.hashCode ^
      currentPage.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          sermons == other.sermons &&
          events == other.events &&
          calendarEvents == other.calendarEvents &&
          currentPage == other.currentPage;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, sermons: $sermons, events: $events, calendarEvents: $calendarEvents, currentPage: $currentPage}';
  }
}
