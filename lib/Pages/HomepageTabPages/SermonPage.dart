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

class SermonPageContainer extends StatelessWidget {
  SermonPageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return SermonPage(
          sermons: vm.sermons,
        );
      },
    );
  }
}

class SermonPage extends StatefulWidget {
  final List<Sermon> sermons;

  SermonPage({Key key, @required this.sermons}) : super(key: key);

  @override
  _SermonPageState createState() => new _SermonPageState();
}

class _SermonPageState extends State<SermonPage> {
  @override
  Widget build(BuildContext context) {
    // Get Widgets of Sermons in monthYear buckets
    Map<DateTime, List<Widget>> monthYearWidgets =
        getMonthYearBucketOrder(widget.sermons);

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
  final List<Sermon> sermons;

  _ViewModel({
    @required this.sermons,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final sermons = sermonsSelector(store.state);

    return _ViewModel(
      sermons: sermons,
    );
  }
}
