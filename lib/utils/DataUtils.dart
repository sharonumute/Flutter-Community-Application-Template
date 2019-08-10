import 'package:flutter/material.dart';

bool notNull(Object o) => o != null;

class Event {
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

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return new Event(
      startDate: DateTime.parse(parsedJson['start_date']),
      endDate: DateTime.parse(parsedJson['end_date']),
      title: parsedJson['title'],
      details: parsedJson['details'],
      imageUrl: parsedJson['image_url'],
      color: Color(int.parse(parsedJson['color'], radix: 16) + 0xFF000000),
    );
  }
}

class SermonObject {
  String title;
  String sermon;
  DateTime date;
  Person preacher;
  String imageUrl;

  SermonObject({
    this.date,
    this.title,
    this.sermon,
    this.imageUrl,
    this.preacher,
  });

  factory SermonObject.fromJson(Map<String, dynamic> parsedJson) {
    return SermonObject(
      date: DateTime.parse(parsedJson['date']),
      title: parsedJson['title'],
      sermon: parsedJson['sermon'],
      imageUrl: parsedJson['image_url'],
      preacher: new Person.fromJson(parsedJson['preacher']),
    );
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
