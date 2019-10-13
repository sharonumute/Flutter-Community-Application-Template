import 'dart:math';

import 'package:community_application/Models/DateTimeObject.dart';
import 'package:flutter/material.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';
import 'package:flutter/material.dart' as prefix0;

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
    if (endDate == null) {
      return isOnOrAfter(this.startDate, startDate.toUtc());
    }

    if (startDate == null) {
      return isOnOrBefore(this.endDate, endDate.toUtc());
    }

    if (isOnOrAfter(this.startDate, startDate.toUtc()) &&
        isOnOrBefore(this.endDate, endDate.toUtc())) {
      return true;
    }

    if (isOnOrBefore(this.startDate, startDate.toUtc()) &&
        isOnOrBefore(this.endDate, endDate.toUtc()) &&
        isOnOrAfter(this.endDate, startDate.toUtc())) {
      return true;
    }

    if (isOnOrBefore(this.startDate, endDate.toUtc()) &&
        isOnOrAfter(this.startDate, startDate.toUtc()) &&
        isOnOrAfter(this.endDate, endDate.toUtc())) {
      return true;
    }

    if (isOnOrBefore(this.startDate, startDate.toUtc()) &&
        isOnOrAfter(this.endDate, endDate.toUtc())) {
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
    reocurrenceEndDate = minDate(
        DateTime.parse(parsedJson['recurrence']['end']).toUtc(), maxDate);
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
