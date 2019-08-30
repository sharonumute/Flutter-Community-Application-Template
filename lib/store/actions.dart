import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Store/State.dart';
import 'package:redux/redux.dart';

class FetchSermonsAction {
  final Store<AppState> store;

  FetchSermonsAction(this.store);

  @override
  String toString() {
    return 'Fetching sermons...';
  }
}

class SermonsLoadedAction {
  final List<Sermon> sermons;

  SermonsLoadedAction(this.sermons);

  @override
  String toString() {
    return 'SermonsLoadedAction{sermons: $sermons}';
  }
}

class SermonSelectedAction {
  final Sermon sermon;

  SermonSelectedAction(this.sermon);

  @override
  String toString() {
    return 'SermonSelectedAction{sermon: $sermon}';
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
