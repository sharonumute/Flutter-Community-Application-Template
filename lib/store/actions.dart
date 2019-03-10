import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/store/state.dart';
import 'package:redux/redux.dart';

/// Sermon Actions
class FetchSermonsAction {
  final Store<AppState> store;

  FetchSermonsAction(this.store);

  @override
  String toString() {
    return 'Fetching sermons...';
  }
}

class SermonsLoadedAction {
  final List<SermonObject> sermons;

  SermonsLoadedAction(this.sermons);

  @override
  String toString() {
    return 'SermonsLoadedAction{sermons: $sermons}';
  }
}

class SermonSelectedAction {
  final SermonObject sermon;

  SermonSelectedAction(this.sermon);

  @override
  String toString() {
    return 'SermonSelectedAction{sermon: $sermon}';
  }
}

///Calendar Event Actions
class FetchCalendarEventsAction {
  final Store<AppState> store;

  FetchCalendarEventsAction(this.store);

  @override
  String toString() {
    return 'Fetching calendar events...';
  }
}

class CalendarEventsLoadedAction {
  final Map<DateTime, List<Event>> calendarEvents;

  CalendarEventsLoadedAction(this.calendarEvents);

  @override
  String toString() {
    return 'CalendarEventsLoadedAction{calendar events: $calendarEvents}';
  }
}

///Event Actions
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

/// Page Actions
class ChangePageAction {
  final String page;

  ChangePageAction(this.page);

  @override
  String toString() {
    return 'ChangePageAction{page: $page}';
  }
}
