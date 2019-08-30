import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Components/EventItemDateBucket.dart';
import 'package:service_application/Components/WidgetMonthYearBucket.dart';
import 'package:service_application/Components/SermonItem.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';

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
          feed: vm.feed,
        );
      },
    );
  }
}

class FeedPage extends StatefulWidget {
  final List<DatetimeObject> feed;

  FeedPage({Key key, @required this.feed}) : super(key: key);

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    List<DatetimeObject> reversedSortedDateTimeObject = widget.feed
      ..sort((a, b) => b.compareTo(a))
      ..toList();
    Map<DateTime, List<DatetimeObject>> monthYearDateTimeObject = {};
    Map<DateTime, List<Widget>> monthYearWidgets = {};

    // Create MonthYear buckets of the DateTimeObjects
    List<DateTime> checkedMonthYearPairs = [];
    for (DatetimeObject item in reversedSortedDateTimeObject) {
      DateTime itemDate = item.getComparisonDate();
      DateTime monthYear = new DateTime(itemDate.year, itemDate.month);
      if (!checkedMonthYearPairs.contains(monthYear)) {
        if (monthYearDateTimeObject[monthYear] == null) {
          monthYearDateTimeObject[monthYear] = new List<DatetimeObject>();
        }

        List<DatetimeObject> itemsThisMonthYear = reversedSortedDateTimeObject
            .where((item) => item.isInRange(
                new DateTime(monthYear.year, monthYear.month, 1),
                getMonthEnd(monthYear.year, monthYear.month)))
            .toList();

        monthYearDateTimeObject[monthYear] = itemsThisMonthYear;
        checkedMonthYearPairs.add(monthYear);
      }
    }

    // Create MonthYear buckets of the DateTimeObjects as Widgets
    for (MapEntry<DateTime, List<DatetimeObject>> monthYearObjectsPair
        in monthYearDateTimeObject.entries) {
      DateTime monthYear = monthYearObjectsPair.key;
      List<DatetimeObject> monthYearObjects = monthYearObjectsPair.value;
      if (monthYearWidgets[monthYear] == null) {
        monthYearWidgets[monthYear] = new List<Widget>();
      }

      List<Widget> widgetsInThisMonthYear = [];

      // Create daily buckets of the DateTimeObjects as Widgets for current MonthYear
      List<DateTime> checkedDaysInCurrentMonthYearPair = [];
      for (DatetimeObject monthYearObject in monthYearObjects) {
        DateTime currentMonthYearObjectDate =
            monthYearObject.getComparisonDate();
        DateTime currentMonthYearObjectDay = new DateTime(
            currentMonthYearObjectDate.year,
            currentMonthYearObjectDate.month,
            currentMonthYearObjectDate.day);

        if (!checkedDaysInCurrentMonthYearPair
            .contains(currentMonthYearObjectDay)) {
          List<DatetimeObject> dateTimeObjectThisDay = monthYearObjects
              .where((item) => item.isInRange(
                  new DateTime(
                      currentMonthYearObjectDay.year,
                      currentMonthYearObjectDay.month,
                      currentMonthYearObjectDay.day,
                      0,
                      0,
                      0),
                  new DateTime(
                      currentMonthYearObjectDay.year,
                      currentMonthYearObjectDay.month,
                      currentMonthYearObjectDay.day,
                      23,
                      59,
                      59)))
              .toList();

          List<Event> eventsInThisDay = [];
          List<Sermon> sermonsInThisDay = [];
          if (dateTimeObjectThisDay != null &&
              dateTimeObjectThisDay.isNotEmpty) {
            for (DatetimeObject object in dateTimeObjectThisDay) {
              if (object.runtimeType == Sermon) {
                sermonsInThisDay.add(object);
              } else if (object.runtimeType == Event) {
                eventsInThisDay.add(object);
              }
            }
          }

          // Add Sermons in this day as individual sermon widgets
          for (Sermon sermon in sermonsInThisDay) {
            widgetsInThisMonthYear.add(new SermonItemContainer(sermon: sermon));
          }

          // Add Eevnts in this day into a single EventItemDateBucket widget
          if (eventsInThisDay.isNotEmpty) {
            widgetsInThisMonthYear.add(new EventItemDateBucket(
                date: currentMonthYearObjectDay, events: eventsInThisDay));
          }

          checkedDaysInCurrentMonthYearPair.add(currentMonthYearObjectDay);
        }
      }

      monthYearWidgets[monthYear] = widgetsInThisMonthYear;
    }

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
