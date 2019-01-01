import "package:intl/intl.dart";

final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
final DateFormat _dayFormat = new DateFormat("dd");
final DateFormat _firstDayFormat = new DateFormat("MMM dd");
final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");

String formatMonth(DateTime d) => _monthFormat.format(d);
String formatDay(DateTime d) => _dayFormat.format(d);
String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

const List<String> weekdays = const [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat"
];
Iterable<DateTime> onlyDaysInRange(DateTime start, DateTime end) sync* {
  var i = start;
  var offset = start.timeZoneOffset;
  while (i.isBefore(end)) {
    yield i;
    i = i.add(new Duration(days: 1));
    var timeZoneDiff = i.timeZoneOffset - offset;
    if (timeZoneDiff.inSeconds != 0) {
      offset = i.timeZoneOffset;
      i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
    }
    i = new DateTime(i.year, i.month, i.day, 0, 0, 0, 0);
  }
}
