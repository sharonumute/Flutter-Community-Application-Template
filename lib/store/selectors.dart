import '../utils/widgetUtils.dart';
import "./state.dart";

List<SermonObject> sermonsSelector(AppState state) => state.sermons;
List<Event> eventsSelector(AppState state) => state.events;
