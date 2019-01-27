import '../utils/widgetUtils.dart';

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

class ChangePageAction {
  final String page;

  ChangePageAction(this.page);

  @override
  String toString() {
    return 'ChangePageAction{page: $page}';
  }
}
