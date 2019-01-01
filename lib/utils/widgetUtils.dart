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
