import 'package:flutter/material.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

abstract class DatetimeObject implements Comparable<DatetimeObject> {
  DateTime getComparisonDate();
  String getTitle();

  @override
  int compareTo(DatetimeObject other) {
    if (this.getComparisonDate().isAfter(other.getComparisonDate())) {
      return 1;
    } else if (this
        .getComparisonDate()
        .isAtSameMomentAs(other.getComparisonDate())) {
      return 0;
    } else {
      return -1;
    }
  }

  bool isInRange(DateTime start, DateTime end);
}

class Event extends DatetimeObject {
  DateTime startDate;
  DateTime endDate;
  String title;
  String details;
  String imageUrl;
  Color color;

  Event({
    this.startDate,
    this.endDate,
    this.title,
    this.details,
    this.imageUrl,
    this.color,
  });

  factory Event.fromJson(Map<String, dynamic> parsedJson,
      {DateTime preferredStartDate, DateTime preferredEndDate}) {
    return new Event(
      startDate: preferredStartDate.toUtc() ??
          DateTime.parse(parsedJson['start']).toUtc(),
      endDate:
          preferredEndDate.toUtc() ?? DateTime.parse(parsedJson['end']).toUtc(),
      title: parsedJson['title'],
      details: parsedJson['details'],
      imageUrl: parsedJson['image_url'],
      color: Color(int.parse(parsedJson['color'], radix: 16) + 0xFF000000)
              .withOpacity(0.8) ??
          getRandomColor(),
    );
  }

  @override
  String getTitle() {
    return this.title;
  }

  @override
  DateTime getComparisonDate() {
    return this.startDate;
  }

  @override
  bool isInRange(DateTime startDate, DateTime endDate) {
    DateTime start = startDate.toUtc();
    DateTime end = endDate.toUtc();

    if (end == null) {
      if (isOnOrAfter(this.startDate, start)) {
        return true;
      }
      return false;
    }

    if (start == null) {
      if (isOnOrBefore(this.endDate, end)) {
        return true;
      }
      return false;
    }

    if (isOnOrAfter(this.startDate, start) && isOnOrBefore(this.endDate, end)) {
      return true;
    }

    if (isOnOrBefore(this.startDate, start) &&
        isOnOrBefore(this.endDate, end) &&
        isOnOrAfter(this.endDate, start)) {
      return true;
    }

    if (isOnOrBefore(this.startDate, end) &&
        isOnOrAfter(this.startDate, start) &&
        isOnOrAfter(this.endDate, end)) {
      return true;
    }

    if (isOnOrBefore(this.startDate, start) && isOnOrAfter(this.endDate, end)) {
      return true;
    }
    return false;
  }
}

List<Event> createEventsFrom(Map<String, dynamic> parsedJson) {
  bool isRecurringEvent = parsedJson['recurrence']['status'];
  String reocurrenceFrequency = parsedJson['recurrence']['frequency'];

  DateTime eventStartDate = DateTime.parse(parsedJson['start']).toUtc();
  DateTime eventEndDate = DateTime.parse(parsedJson['end']).toUtc();

  DateTime reocurrenceEndDate;
  String reocurrenceEndDateString = parsedJson['recurrence']['end'];
  if (reocurrenceEndDateString == null) {
    reocurrenceEndDate = maxDate;
  } else {
    reocurrenceEndDate =
        DateTime.parse(parsedJson['recurrence']['end']).toUtc();
  }

  if (isRecurringEvent) {
    int nthDay = 0;
    switch (reocurrenceFrequency) {
      case "DAILY":
        nthDay = 1;
        break;
      case "WEEKLY":
        nthDay = 7;
        break;
      case "MONTHLY":
        nthDay = 30;
        break;
      case "YEARLY":
        nthDay = 365;
        break;
      default:
        break;
    }

    List<Event> events = [];
    DateTime newEndDate = eventEndDate;
    for (DateTime newStartDate in everyNthDayWithin(
        eventStartDate, reocurrenceEndDate.add(Duration(days: 1)), nthDay)) {
      List<Event> eventsWithOnGoingHandler =
          onGoingEventHandler(newStartDate, newEndDate, parsedJson);

      events.addAll(eventsWithOnGoingHandler);
      newEndDate = newEndDate.add(Duration(days: nthDay));
    }
    return events;
  } else {
    List<Event> eventsWithOnGoingHandler =
        onGoingEventHandler(eventStartDate, eventEndDate, parsedJson);
    return eventsWithOnGoingHandler;
  }
}

List<Event> onGoingEventHandler(
    DateTime startDate, DateTime endDate, Map<String, dynamic> parsedJson) {
  bool isOnGoingEvent = !isAtSameDayAs(startDate, endDate);

  if (isOnGoingEvent) {
    List<Event> events = [];
    Event newStartDayTillEndOfDay = Event.fromJson(parsedJson,
        preferredStartDate: startDate,
        preferredEndDate: new DateTime.utc(
            startDate.year, startDate.month, startDate.day, 23, 59, 59));
    events.add(newStartDayTillEndOfDay);

    for (DateTime inBetweenDate in everyNthDayWithin(
        startDate.add(Duration(days: 1)),
        endDate.subtract(Duration(days: 1)),
        1)) {
      Event inbetweenDay = Event.fromJson(parsedJson,
          preferredStartDate: new DateTime.utc(
            inBetweenDate.year,
            inBetweenDate.month,
            inBetweenDate.day,
            0,
            0,
            0,
          ),
          preferredEndDate: new DateTime.utc(inBetweenDate.year,
              inBetweenDate.month, inBetweenDate.day, 23, 59, 59));

      events.add(inbetweenDay);
    }
    Event newEndDayFromStartOfDay = Event.fromJson(parsedJson,
        preferredStartDate:
            new DateTime.utc(endDate.year, endDate.month, endDate.day, 0, 0, 0),
        preferredEndDate: endDate);
    events.add(newEndDayFromStartOfDay);
    return events;
  } else {
    List<Event> events = [];
    events.add(Event.fromJson(parsedJson,
        preferredStartDate: startDate, preferredEndDate: endDate));
    return events;
  }
}

class Sermon extends DatetimeObject {
  String title;
  String content;
  DateTime date;
  Person author;
  String imageUrl;

  Sermon({
    this.date,
    this.title,
    this.content,
    this.imageUrl,
    this.author,
  });

  factory Sermon.fromJson(Map<String, dynamic> parsedJson) {
    return Sermon(
      date: DateTime.parse(parsedJson['date']).toUtc(),
      title: parsedJson['title'],
      content: parsedJson['sermon'],
      imageUrl: parsedJson['image_url'],
      author: new Person.fromJson(parsedJson['preacher']),
    );
  }

  @override
  String getTitle() {
    return this.title;
  }

  @override
  DateTime getComparisonDate() {
    return this.date.toUtc();
  }

  @override
  bool isInRange(DateTime startDate, DateTime endDate) {
    DateTime start = startDate.toUtc();
    DateTime end = endDate.toUtc();

    if (end == null) {
      if (isOnOrAfter(this.date, start)) {
        return true;
      }
      return false;
    }

    if (start == null) {
      if (isOnOrBefore(this.date, end)) {
        return true;
      }
      return false;
    }

    return isOnOrAfter(this.date, start) && isOnOrBefore(this.date, end);
  }
}

class Person {
  String name;
  String imageUrl;
  String personInformation;

  Person({
    this.name,
    this.imageUrl,
    this.personInformation,
  });

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    return Person(
      name: parsedJson['name'],
      imageUrl: parsedJson['image_url'],
      personInformation: parsedJson['person_information'],
    );
  }
}

/// From of `https://pub.dartlang.org/packages/flutter_calendar#-readme-tab-` to include events
class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return new AnimatedCrossFade(
      firstChild: collapsed,
      secondChild: expanded,
      firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.decelerate,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
