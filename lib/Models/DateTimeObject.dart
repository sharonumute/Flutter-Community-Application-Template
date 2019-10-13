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
