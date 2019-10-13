import "package:intl/intl.dart";

/// Set application max date to a year from now
final DateTime maxDate = new DateTime.now().toUtc().add(Duration(days: 365));

const List<String> weekdays = const [
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun"
];
const List<String> months = const [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
final DateFormat _dayFormat = new DateFormat("dd");
final DateFormat _firstDayFormat = new DateFormat("MMM dd");
final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");
final DateFormat _presentationFullDayFormat = new DateFormat("MMMM dd, yyyy");

String formatMonth(DateTime d) => _monthFormat.format(d);
String formatDay(DateTime d) => _dayFormat.format(d);
String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
String presentationFullDayFormat(DateTime d) =>
    _presentationFullDayFormat.format(d);

Iterable<DateTime> everyNthDayWithin(
    DateTime start, DateTime end, int n) sync* {
  var i = start;
  var offset = start.timeZoneOffset;
  while (i.isBefore(end)) {
    yield i;
    i = i.add(new Duration(days: n));
    var timeZoneDiff = i.timeZoneOffset - offset;
    if (timeZoneDiff.inSeconds != 0) {
      offset = i.timeZoneOffset;
      i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
    }
  }
}

String timeParseToString(DateTime time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

String startToEndDate(DateTime startDate, DateTime endDate) {
  if (isAtSameDayAs(startDate, endDate)) {
    return "${presentationFullDayFormat(startDate)}";
  }
  return "${presentationFullDayFormat(startDate)} - ${presentationFullDayFormat(endDate)}";
}

String startToEndTime(DateTime startTime, DateTime endTime) {
  if (startTime.hour == endTime.hour && startTime.minute == endTime.minute) {
    return "${timeParseToString(startTime)}";
  }

  if ((startTime.hour == 0 &&
      startTime.minute == 0 &&
      endTime.hour == 23 &&
      endTime.minute == 59)) {
    return "All day";
  }

  return "${timeParseToString(startTime)} - ${timeParseToString(endTime)}";
}

bool isAtSameDayAs(DateTime date1, DateTime date2) {
  DateTime day1 = new DateTime.utc(date1.year, date1.month, date1.day);
  DateTime day2 = new DateTime.utc(date2.year, date2.month, date2.day);
  return day1.isAtSameMomentAs(day2);
}

bool isOnOrAfter(DateTime first, DateTime second) {
  return first.isAfter(second) || first.isAtSameMomentAs(second);
}

bool isOnOrBefore(DateTime first, DateTime second) {
  return first.isBefore(second) || first.isAtSameMomentAs(second);
}

DateTime getMonthEnd(int year, int month) {
  int nextMonth = month == 12 ? 1 : month + 1;
  return new DateTime.utc(year, nextMonth, 0);
}

DateTime minDate(DateTime first, DateTime second) {
  if (first.isBefore(second)) {
    return first;
  }
  return second;
}
