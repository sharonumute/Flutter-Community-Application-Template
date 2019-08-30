import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Pages/ComponentPages/EventItemPage.dart';
import 'package:service_application/Utils/CommonUtils.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Store/Actions.dart';
import 'package:service_application/Strings/ErrorMessages.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

class EventItemContainer extends StatelessWidget {
  final Event event;
  final int numberOfLinesOnMinimized;

  EventItemContainer({Key key, this.event, this.numberOfLinesOnMinimized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, event);
      },
      builder: (context, vm) {
        return EventItem(
          event: event,
          numberOfLinesOnMinimized: numberOfLinesOnMinimized,
          onEventSelected: vm.onEventSelected,
        );
      },
    );
  }
}

class EventItem extends StatefulWidget {
  EventItem({
    Key key,
    this.event,
    this.numberOfLinesOnMinimized,
    this.onEventSelected,
  }) : super(key: key);

  final Event event;
  final int numberOfLinesOnMinimized;
  final Function onEventSelected;

  @override
  _EventItemState createState() => new _EventItemState();
}

class _EventItemState extends State<EventItem> {
  void _openEvent() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EventItemPage(event: widget.event);
        },
      ),
    );
  }

  void _onEventSelected() {
    this._openEvent();

    try {
      widget.onEventSelected();
    } on NoSuchMethodError {
      print(STORELESS_COMPONENT_WITH_UNDEFINED_VIEWMODEL_FUNCTION);
    }
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
  final Function onEventSelected;

  _ViewModel({
    @required this.onEventSelected,
  });

  factory _ViewModel.from(Store<AppState> store, Event event) {
    return _ViewModel(
      onEventSelected: () => store.dispatch(EventSelectedAction(event)),
    );
  }
}
