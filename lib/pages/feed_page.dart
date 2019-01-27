import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../store/selectors.dart';
import '../store/state.dart';
import '../utils/widgetUtils.dart';

class FeedPageConatiner extends StatelessWidget {
  FeedPageConatiner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return FeedPage(
          events: vm.events,
        );
      },
    );
  }
}

class FeedPage extends StatelessWidget {
  final List<Event> events;

  FeedPage({Key key, @required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Center(),
    );
  }
}

class _ViewModel {
  final List<Event> events;

  _ViewModel({
    @required this.events,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final events = eventsSelector(store.state);

    return _ViewModel(
      events: events,
    );
  }
}
