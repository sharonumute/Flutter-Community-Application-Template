import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Components/FeedItem.dart';

class FeedPageContainer extends StatelessWidget {
  FeedPageContainer({Key key}) : super(key: key);

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

class FeedPage extends StatefulWidget {
  final List<Event> events;

  FeedPage({Key key, @required this.events}) : super(key: key);

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.only(top: paddingFromWalls),
        itemCount: widget.events.length,
        itemBuilder: (BuildContext context, int index) {
          return new FeedItemContainer(event: widget.events[index]);
        },
      ),
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
