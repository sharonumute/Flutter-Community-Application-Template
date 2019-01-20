import '../globals.dart' as global;
import 'package:flutter/material.dart';

bool notNull(Object o) => o != null;

class Event {
  DateTime startDate;
  DateTime endDate;
  String title;
  String details;
  String imageUrl;
  Color color;

  Event(DateTime startDate, DateTime endDate, String title, String details,
      String imageUrl, Color color) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.title = title;
    this.details = details;
    this.imageUrl = imageUrl;
    this.color = color;
  }
}

class SermonObject {
  String title;
  String content;
  DateTime date;
  Person speaker;
  String imageUrl;

  SermonObject(DateTime date, String title, String content, String imageUrl,
      Person speaker) {
    this.date = date;
    this.title = title;
    this.content = content;
    this.imageUrl = imageUrl;
    this.speaker = speaker;
  }
}

class Person {
  String name;
  String imageUrl;
  String personInformation;

  Person(String name, String imageUrl, String content) {
    this.name = name;
    this.imageUrl = imageUrl;
    this.personInformation = personInformation;
  }
}

/// From of `https://pub.dartlang.org/packages/flutter_calendar#-readme-tab-` to include events
class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;
  final int flex;

  ExpansionCrossFade(
      {this.collapsed, this.expanded, this.isExpanded, this.flex});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      flex: this.flex ?? 1,
      child: new AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
