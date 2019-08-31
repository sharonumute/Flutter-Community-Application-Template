import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:service_application/Components/CalendarTile.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:date_utils/date_utils.dart';
import 'package:service_application/Globals/Values.dart';

typedef DayBuilder(BuildContext context, DateTime day);

/// Modification of `https://pub.dartlang.org/packages/flutter_calendar#-readme-tab-` to include events
class Calendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final bool isExpandable;
  final DayBuilder dayBuilder;
  final bool showChevronsToChangeRange;
  final bool showTodayAction;
  final bool showCalendarPickerIcon;
  final DateTime initialCalendarDateOverride;
  final List<Event> events;

  Calendar(
      {this.onDateSelected,
      this.onSelectedRangeChange,
      this.isExpandable: false,
      this.dayBuilder,
      this.showTodayAction: true,
      this.showChevronsToChangeRange: true,
      this.showCalendarPickerIcon: true,
      this.initialCalendarDateOverride,
      this.events});

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = new Utils();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate = new DateTime.now();
  String currentMonth;
  bool isExpanded = false;
  String displayMonth;
  DateTime get selectedDate => _selectedDate;

  void initState() {
    super.initState();
    if (widget.initialCalendarDateOverride != null)
      _selectedDate = widget.initialCalendarDateOverride;
    selectedMonthsDays = Utils.daysInMonth(_selectedDate);
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
    selectedWeeksDays = everyNthDayWithin(
            new DateTime.utc(firstDayOfCurrentWeek.year,
                firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
            new DateTime.utc(lastDayOfCurrentWeek.year,
                lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
            1)
        .toList()
        .sublist(0, 7);
    displayMonth = Utils.formatMonth(_selectedDate);
  }

  Widget get nameAndIconRow {
    var leftInnerIcon;
    var rightInnerIcon;
    var leftOuterIcon;
    var rightOuterIcon;

    if (widget.showCalendarPickerIcon) {
      rightInnerIcon = new IconButton(
        onPressed: () => selectDateFromPicker(),
        icon: new Icon(Icons.calendar_today,
            color: Theme.of(context).colorScheme.onPrimary),
      );
    } else {
      rightInnerIcon = new Container();
    }

    if (widget.showChevronsToChangeRange) {
      leftOuterIcon = new IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: new Icon(Icons.chevron_left,
            color: Theme.of(context).colorScheme.onPrimary),
      );
      rightOuterIcon = new IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: new Icon(Icons.chevron_right,
            color: Theme.of(context).colorScheme.onPrimary),
      );
    } else {
      leftOuterIcon = new Container();
      rightOuterIcon = new Container();
    }

    if (widget.showTodayAction) {
      leftInnerIcon = new InkWell(
        child: new Text(
          'Today',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onTap: resetToToday,
      );
    } else {
      leftInnerIcon = new Container();
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftOuterIcon ?? new Container(),
        leftInnerIcon ?? new Container(),
        new Text(
          displayMonth,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        rightInnerIcon ?? new Container(),
        rightOuterIcon ?? new Container(),
      ],
    );
  }

  Widget get calendarGridView {
    return new Container(
      child: new GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: new GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          padding: new EdgeInsets.only(bottom: 0.0),
          children: calendarBuilder(),
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeeksDays.toList();

    Utils.weekdays.forEach(
      (day) {
        dayWidgets.add(
          new CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
            dayOfWeekStyles:
                new TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (this.widget.dayBuilder != null) {
          dayWidgets.add(
            new CalendarTile(
                child: this.widget.dayBuilder(context, day),
                date: day,
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                validEventTest: widget.events
                    .where((event) => event.isInRange(
                        new DateTime.utc(day.year, day.month, day.day, 0, 0, 0),
                        new DateTime.utc(
                            day.year, day.month, day.day, 23, 59, 59)))
                    .toList()),
          );
        } else {
          dayWidgets.add(
            new CalendarTile(
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: configureDateStyle(monthStarted, monthEnded),
                isSelected: Utils.isSameDay(selectedDate, day),
                validEventTest: widget.events
                    .where((event) => event.isInRange(
                        new DateTime.utc(day.year, day.month, day.day, 0, 0, 0),
                        new DateTime.utc(
                            day.year, day.month, day.day, 23, 59, 59)))
                    .toList()),
          );
        }
      },
    );
    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded) {
    TextStyle dateStyles;
    if (isExpanded) {
      dateStyles = monthStarted && !monthEnded
          ? new TextStyle(color: Theme.of(context).colorScheme.onPrimary)
          : new TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.38));
    } else {
      dateStyles =
          new TextStyle(color: Theme.of(context).colorScheme.onPrimary);
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.only(left: paddingFromWalls),
            child: new Text(
              Utils.fullDayFormat(selectedDate),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          new IconButton(
            iconSize: 20.0,
            padding: new EdgeInsets.all(0.0),
            onPressed: toggleExpanded,
            icon: isExpanded
                ? new Icon(Icons.arrow_drop_up)
                : new Icon(Icons.arrow_drop_down),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      );
    } else {
      return new Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(0),
      elevation: 0,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          new ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          expansionButtonRow
        ],
      ),
    );
  }

  void resetToToday() {
    _selectedDate = new DateTime.now();
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeeksDays = everyNthDayWithin(
              new DateTime.utc(firstDayOfCurrentWeek.year,
                  firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
              new DateTime.utc(lastDayOfCurrentWeek.year,
                  lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
              1)
          .toList();
      displayMonth = Utils.formatMonth(_selectedDate);
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = Utils.nextMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousMonth() {
    setState(() {
      _selectedDate = Utils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void nextWeek() {
    setState(() {
      _selectedDate = Utils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays = everyNthDayWithin(
              new DateTime.utc(firstDayOfCurrentWeek.year,
                  firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
              new DateTime.utc(lastDayOfCurrentWeek.year,
                  lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
              1)
          .toList()
          .sublist(0, 7);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    setState(() {
      _selectedDate = Utils.previousWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays = everyNthDayWithin(
              new DateTime.utc(firstDayOfCurrentWeek.year,
                  firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
              new DateTime.utc(lastDayOfCurrentWeek.year,
                  lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
              1)
          .toList()
          .sublist(0, 7);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    var selectedRange = new Tuple2<DateTime, DateTime>(start, end);
    if (widget.onSelectedRangeChange != null) {
      widget.onSelectedRangeChange(selectedRange);
    }
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime.utc(1960),
      lastDate: new DateTime.utc(2050),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays = everyNthDayWithin(
                new DateTime.utc(firstDayOfCurrentWeek.year,
                    firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
                new DateTime.utc(lastDayOfCurrentWeek.year,
                    lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
                1)
            .toList()
            .sublist(0, 7);
        selectedMonthsDays = Utils.daysInMonth(selected);
        displayMonth = Utils.formatMonth(selected);
      });
      // updating selected date range based on selected week
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      _launchDateSelectionCallback(selected);
    }
  }

  var gestureStart;
  var gestureDirection;

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (isExpanded) {
        nextMonth();
      } else {
        nextWeek();
      }
    } else {
      if (isExpanded) {
        previousMonth();
      } else {
        previousWeek();
      }
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
    setState(() {
      _selectedDate = day;
      selectedWeeksDays = everyNthDayWithin(
              new DateTime.utc(firstDayOfCurrentWeek.year,
                  firstDayOfCurrentWeek.month, firstDayOfCurrentWeek.day),
              new DateTime.utc(lastDayOfCurrentWeek.year,
                  lastDayOfCurrentWeek.month, lastDayOfCurrentWeek.day),
              1)
          .toList();
      selectedMonthsDays = Utils.daysInMonth(day);
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected(day);
    }
  }
}
