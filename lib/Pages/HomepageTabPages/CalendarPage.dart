import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Components/EventWidgetDayDateBucket.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Components/CalendarWidget.dart';
import 'package:community_application/Store/Selectors.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Store/Actions.dart';

class CalendarPageContainer extends StatelessWidget {
  final String searchValue;

  CalendarPageContainer({Key key, this.searchValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return CalendarPage(
          events: vm.events,
          userSelectedCalendarDate: vm.currentSelectedCalendarDate,
          setCurrentSelectedCalendarDate: vm.setCurrentSelectedCalendarDate,
          searchValue: searchValue,
        );
      },
    );
  }
}

class CalendarPage extends StatefulWidget {
  final String searchValue;
  final List<Event> events;
  final String userSelectedCalendarDate;
  final Function setCurrentSelectedCalendarDate;

  CalendarPage(
      {Key key,
      @required this.events,
      @required this.userSelectedCalendarDate,
      @required this.setCurrentSelectedCalendarDate,
      this.searchValue})
      : super(key: key);

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Widget> _currentDisplayedEvents = [];

  void changeCurrentDisplayedDates(DateTime day) {
    List<Widget> eventsToDisplay = [];
    List<Event> eventsThisDay = widget.events
        .where((event) =>
            event.isInRange(
                new DateTime.utc(day.year, day.month, day.day, 0, 0, 0),
                new DateTime.utc(day.year, day.month, day.day, 23, 59, 59)) &&
            event
                .getTitle()
                .toLowerCase()
                .contains(widget.searchValue.toLowerCase()))
        .toList();

    if (eventsThisDay != null && eventsThisDay.isNotEmpty) {
      eventsToDisplay
          .add(new EventWidgetDateBucket(date: day, events: eventsThisDay));
    }

    setState(() {
      _currentDisplayedEvents = eventsToDisplay;
    });

    widget.setCurrentSelectedCalendarDate(day);
  }

  @override
  void initState() {
    super.initState();
    changeCurrentDisplayedDates(
        DateTime.parse(widget.userSelectedCalendarDate).toUtc());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Calendar(
            isExpandable: true,
            onDateSelected: (date) => changeCurrentDisplayedDates(date),
            events: widget.events,
            initialCalendarDateOverride:
                DateTime.parse(widget.userSelectedCalendarDate).toUtc(),
          ),
          new Padding(
            padding: EdgeInsets.all(dividerPadding),
          ),
          new Column(
            children: _currentDisplayedEvents,
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final List<Event> events;
  final String currentSelectedCalendarDate;
  final Function setCurrentSelectedCalendarDate;

  _ViewModel({
    @required this.events,
    @required this.currentSelectedCalendarDate,
    @required this.setCurrentSelectedCalendarDate,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
        events: eventsSelector(store.state),
        currentSelectedCalendarDate:
            currentSelectedCalendarDateSelector(store.state),
        setCurrentSelectedCalendarDate: (DateTime userSelectedDate) =>
            store.dispatch(new SetCurrentSelectedCalendarDateAction(
                userSelectedDate.toString())));
  }
}
