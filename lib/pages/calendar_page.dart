import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/globals.dart' as global;
import 'package:service_application/imported_widgets/flutter_calendar.dart';
import 'package:service_application/store/selectors.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/reusable_widgets/feed_item.dart';

class CalendarPageConatiner extends StatelessWidget {
  CalendarPageConatiner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return CalendarPage(
          events: vm.calendarEvents,
        );
      },
    );
  }
}

class CalendarPage extends StatefulWidget {
  final Map<DateTime, List<Event>> events;

  CalendarPage({Key key, @required this.events}) : super(key: key);

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  /// DateTime shouldn't have Time
  List<Widget> _currentDisplayedEvents = [];

  void changeCurrentDisplayedDates(DateTime day) {
    List<Widget> eventsToDisplay = [];
    List<Event> eventsThisDay = widget.events[day];

    if (eventsThisDay != null && eventsThisDay.isNotEmpty) {
      for (Event event in eventsThisDay) {
        eventsToDisplay.add(new FeedItemConatiner(event: event));
      }
    }

    setState(() {
      _currentDisplayedEvents = eventsToDisplay;
    });
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
          ),
          new Padding(
            padding: EdgeInsets.all(global.dividerPadding),
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
  final Map<DateTime, List<Event>> calendarEvents;

  _ViewModel({
    @required this.calendarEvents,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final eventsReceived = calendarEventsSelector(store.state);

    return _ViewModel(
      calendarEvents: eventsReceived,
    );
  }
}
