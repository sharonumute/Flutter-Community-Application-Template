import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:community_application/Components/EventWidgetDayDateBucket.dart';
import 'package:community_application/Components/ArticleWidget.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Models/DateTimeObject.dart';
import 'package:community_application/Utils/DateUtils.dart';

Widget returnCircleWidget(Widget image, {Color color = Colors.transparent}) {
  return new Material(
    color: color,
    shape: CircleBorder(),
    clipBehavior: Clip.hardEdge,
    child: image,
  );
}

Widget loadingScreen = new Scaffold(
  body: new Center(
    child: new CircularProgressIndicator(),
  ),
);

Widget threePointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding / 2),
);

Widget sixPointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding),
);

Widget twelvePointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding * 2),
);
Color getRandomColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
      .withOpacity(0.3);
}

Map<DateTime, List<Widget>> getMonthYearBucketOrder(
    List<DatetimeObject> dateTimeObjectsToOrder,
    {String filterTitleBy,
    bool dontIncludeFuture = false}) {
  List<DatetimeObject> dateTimeObjectsToOrderSorted = dateTimeObjectsToOrder
    ..sort((a, b) => b.compareTo(a))
    ..toList();

  Map<DateTime, List<DatetimeObject>> monthYearDateTimeObject = {};
  Map<DateTime, List<Widget>> monthYearWidgets = {};

  // Create MonthYear buckets of the DateTimeObjects
  List<DateTime> checkedMonthYearPairs = [];
  for (DatetimeObject item in dateTimeObjectsToOrderSorted) {
    DateTime itemDate = item.getComparisonDate();

    if (dontIncludeFuture && itemDate.isAfter(new DateTime.now().toUtc())) {
      continue;
    }

    DateTime monthYear = new DateTime.utc(itemDate.year, itemDate.month);
    if (!checkedMonthYearPairs.contains(monthYear)) {
      if (monthYearDateTimeObject[monthYear] == null) {
        monthYearDateTimeObject[monthYear] = new List<DatetimeObject>();
      }

      List<DatetimeObject> itemsThisMonthYear = dateTimeObjectsToOrderSorted
          .where((item) =>
              item.isInRange(
                  new DateTime.utc(monthYear.year, monthYear.month, 1),
                  getMonthEnd(monthYear.year, monthYear.month)) &&
              item
                  .getTitle()
                  .toLowerCase()
                  .contains(filterTitleBy.toLowerCase()))
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
      DateTime currentMonthYearObjectDate = monthYearObject.getComparisonDate();
      DateTime currentMonthYearObjectDay = new DateTime.utc(
          currentMonthYearObjectDate.year,
          currentMonthYearObjectDate.month,
          currentMonthYearObjectDate.day);

      if (dontIncludeFuture &&
          currentMonthYearObjectDay.isAfter(new DateTime.now().toUtc())) {
        continue;
      }

      if (!checkedDaysInCurrentMonthYearPair
          .contains(currentMonthYearObjectDay)) {
        List<DatetimeObject> dateTimeObjectThisDay = monthYearObjects
            .where((item) => item.isInRange(
                new DateTime.utc(
                    currentMonthYearObjectDay.year,
                    currentMonthYearObjectDay.month,
                    currentMonthYearObjectDay.day,
                    0,
                    0,
                    0),
                new DateTime.utc(
                    currentMonthYearObjectDay.year,
                    currentMonthYearObjectDay.month,
                    currentMonthYearObjectDay.day,
                    23,
                    59,
                    59)))
            .toList();

        List<Event> eventsInThisDay = [];
        List<Article> articlesInThisDay = [];
        if (dateTimeObjectThisDay != null && dateTimeObjectThisDay.isNotEmpty) {
          for (DatetimeObject object in dateTimeObjectThisDay) {
            if (object.runtimeType == Article) {
              articlesInThisDay.add(object);
            } else if (object.runtimeType == Event) {
              eventsInThisDay.add(object);
            }
          }
        }

        // Add Articles in this day as individual article widgets
        for (Article article in articlesInThisDay) {
          widgetsInThisMonthYear
              .add(new ArticleWidgetContainer(article: article));
        }

        // Add Eevnts in this day into a single EventWidgetDateBucket widget
        if (eventsInThisDay.isNotEmpty) {
          widgetsInThisMonthYear.add(new EventWidgetDateBucket(
              date: currentMonthYearObjectDay, events: eventsInThisDay));
        }

        checkedDaysInCurrentMonthYearPair.add(currentMonthYearObjectDay);
      }
    }

    monthYearWidgets[monthYear] =
        widgetsInThisMonthYear.where(ifObjectIsNotNull).toList();
  }

  return monthYearWidgets;
}

Widget nullWidget() => new Container();
