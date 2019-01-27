import "./state.dart";
import './actions.dart';
import '../utils/widgetUtils.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    sermons: sermonsReducer(state.sermons, action),
    events: eventsReducer(state.events, action),
    currentPage: pageReducer(state.currentPage, action),
  );
}

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, SermonsLoadedAction>(_setLoaded),
  TypedReducer<bool, EventsLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

final sermonsReducer = combineReducers<List<SermonObject>>([
  TypedReducer<List<SermonObject>, SermonsLoadedAction>(loadSermonsIntoApp),
]);

List<SermonObject> loadSermonsIntoApp(
    List<SermonObject> state, SermonsLoadedAction action) {
  return action.sermons;
}

final eventsReducer = combineReducers<List<Event>>([
  TypedReducer<List<Event>, EventsLoadedAction>(loadEventsIntoApp),
]);

List<Event> loadEventsIntoApp(List<Event> state, EventsLoadedAction action) {
  return action.events;
}

final pageReducer = combineReducers<String>([
  TypedReducer<String, ChangePageAction>(setCurrentPage),
]);

String setCurrentPage(String state, ChangePageAction action) {
  return action.page;
}
