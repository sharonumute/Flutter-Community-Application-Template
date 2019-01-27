import 'package:meta/meta.dart';
import '../utils/widgetUtils.dart';
import "../pages/pageController.dart" as PageController;

@immutable
class AppState {
  final bool isLoading;
  final List<SermonObject> sermons;
  final List<Event> events;
  final String currentPage;

  AppState({
    this.isLoading = false,
    this.sermons = const [],
    this.events = const [],
    this.currentPage = PageController.HOME_PAGE,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<SermonObject> sermons,
    List<Event> events,
    String currentPage,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      sermons: sermons ?? this.sermons,
      events: events ?? this.events,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      sermons.hashCode ^
      events.hashCode ^
      currentPage.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          sermons == other.sermons &&
          events == other.events &&
          currentPage == other.currentPage;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, sermons: $sermons, events: $events, currentPage: $currentPage}';
  }
}
