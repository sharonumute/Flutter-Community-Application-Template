import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import '../utils/widgetUtils.dart';

bool notNull(Object o) => o != null;

/// Modification of `https://pub.dartlang.org/packages/flutter_calendar#-readme-tab-` to include events
class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;
  final Map<DateTime, Event> events;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.events,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    bool hasEvent =
        this.events != null ? this.events.containsKey(this.date) : false;
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  dayOfWeek,
                  style: dayOfWeekStyles,
                ),
                hasEvent
                    ? new Padding(
                        padding: EdgeInsets.all(2.0),
                      )
                    : null,
                hasEvent
                    ? new Icon(
                        Icons.brightness_1,
                        color: this.events[this.date].color,
                        size: 6.0,
                      )
                    : null,
              ].where(notNull).toList(),
            )),
      );
    } else {
      return new InkWell(
        onTap: onDateSelected,
        child: new Container(
            decoration: isSelected
                ? new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryTextTheme.body1.color,
                  )
                : new BoxDecoration(),
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  Utils.formatDay(date).toString(),
                  style: isSelected
                      ? new TextStyle(
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Theme.of(context).primaryTextTheme.body1.color
                              : Theme.of(context).primaryColor,
                        )
                      : dateStyles,
                  textAlign: TextAlign.center,
                ),
                hasEvent
                    ? new Padding(
                        padding: EdgeInsets.all(2.0),
                      )
                    : null,
                hasEvent
                    ? new Icon(
                        Icons.brightness_1,
                        color: this.events[this.date].color,
                        size: 6.0,
                      )
                    : null,
              ].where(notNull).toList(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
