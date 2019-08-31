import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Components/WidgetMonthYearBucket.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

class FeedPageContainer extends StatelessWidget {
  final String searchTerm;

  FeedPageContainer({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return FeedPage(
          feed: vm.feed,
          searchTerm: searchTerm,
        );
      },
    );
  }
}

class FeedPage extends StatefulWidget {
  final List<DatetimeObject> feed;
  final String searchTerm;

  FeedPage({Key key, @required this.feed, this.searchTerm}) : super(key: key);

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    // Get Widgets of DatetimeObjects in monthYear buckets
    Map<DateTime, List<Widget>> monthYearWidgets =
        getMonthYearBucketOrder(widget.feed, filterTitleBy: widget.searchTerm);

    // Get iterable list of month year pairs
    List<DateTime> monthYears = monthYearWidgets.keys.toList();

    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.only(top: paddingFromWalls),
        itemCount: monthYearWidgets.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime monthYear = monthYears[index];
          return new WidgetMonthYearBucket(
              date: monthYear, items: monthYearWidgets[monthYear]);
        },
      ),
    );
  }
}

class _ViewModel {
  final List<DatetimeObject> feed;

  _ViewModel({
    @required this.feed,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
      feed: feedSelector(store.state),
    );
  }
}
