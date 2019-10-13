import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Pages/ComponentPages/EventWidgetPage.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Store/Actions.dart';

class EventWidgetContainer extends StatelessWidget {
  final Event event;
  final int numberOfLinesOnMinimized;

  EventWidgetContainer({Key key, this.event, this.numberOfLinesOnMinimized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, event);
      },
      builder: (context, vm) {
        return EventWidget(
          event: event,
          numberOfLinesOnMinimized: numberOfLinesOnMinimized,
          callback: vm.callback,
        );
      },
    );
  }
}

class EventWidget extends StatefulWidget {
  EventWidget({
    Key key,
    this.event,
    this.numberOfLinesOnMinimized,
    this.callback,
  }) : super(key: key);

  final Event event;
  final int numberOfLinesOnMinimized;
  final Function callback;

  @override
  _EventWidgetState createState() => new _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  void _openEvent() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EventWidgetPage(event: widget.event);
        },
      ),
    );
  }

  void _onEventSelected() {
    this._openEvent();
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: widget.event.color,
      margin: const EdgeInsets.only(bottom: marginpaddingFromScreenFlat),
      elevation: cardResting,
      clipBehavior: Clip.antiAlias,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(boxborderRadius),
      ),
      child: InkWell(
        onTap: _onEventSelected,
        child: Container(
          padding: const EdgeInsets.all(paddingFromWalls),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                widget.event.title,
                style: Theme.of(context).textTheme.body1,
              ),
              ifObjectIsNotNull(widget.event.startDate) &&
                      ifObjectIsNotNull(widget.event.endDate)
                  ? new Text(
                      startToEndTime(
                          widget.event.startDate, widget.event.endDate),
                      style: Theme.of(context).textTheme.caption,
                    )
                  : null,
            ].where(ifObjectIsNotNull).toList(),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function callback;

  _ViewModel({
    @required this.callback,
  });

  factory _ViewModel.from(Store<AppState> store, Event event) {
    return _ViewModel(
      callback: () => store.dispatch(EventSelectedAction(event)),
    );
  }
}
