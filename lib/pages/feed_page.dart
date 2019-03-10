import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/globals.dart' as global;
import 'package:service_application/store/selectors.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/reusable_widgets/feed_item.dart';

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
          news: vm.news,
        );
      },
    );
  }
}

class FeedPage extends StatefulWidget {
  final List<Event> news;

  FeedPage({Key key, @required this.news}) : super(key: key);

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.only(top: global.paddingFromScreen),
        itemCount: widget.news.length,
        itemBuilder: (BuildContext context, int index) {
          return new FeedItemConatiner(event: widget.news[index]);
        },
      ),
    );
  }
}

class _ViewModel {
  final List<Event> news;

  _ViewModel({
    @required this.news,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final news = eventsSelector(store.state);

    return _ViewModel(
      news: news,
    );
  }
}
