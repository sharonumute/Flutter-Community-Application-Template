import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Components/EventItem.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

class EventItemDateBucket extends StatelessWidget {
  final List<Event> events;
  final DateTime date;

  EventItemDateBucket({
    Key key,
    @required this.events,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> eventsInThisBucket = [];
    List<DatetimeObject> sortedByTime = events
      ..sort()
      ..toList();
    for (Event event in sortedByTime) {
      eventsInThisBucket.add(
        new Row(
          children: <Widget>[
            new Expanded(
              child: new EventItemContainer(event: event),
            ),
          ],
        ),
      );
    }

    return new Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(0),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: new Container(
        padding: const EdgeInsets.all(marginpaddingFromScreenFlat),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: 40,
              child: new Column(
                children: <Widget>[
                  new Text(weekdays[date.weekday - 1],
                      style: Theme.of(context).textTheme.body2),
                  isAtSameDayAs(date, new DateTime.now())
                      ? returnCircleWidget(
                          new Container(
                            width: 35,
                            height: 35,
                            child: new Center(
                              child: new Text(
                                formatDay(date),
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                        )
                      : new Text(
                          formatDay(date),
                          style: Theme.of(context).textTheme.headline,
                        ),
                ],
              ),
            ),
            new Expanded(
              child: new Container(
                padding: const EdgeInsets.only(
                    left: marginpaddingFromScreenFlat,
                    right: marginpaddingFromScreenFlat),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: eventsInThisBucket,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
