import 'package:flutter/material.dart';
import 'package:service_application/reusable_widgets/expandable_image.dart';
import 'package:service_application/reusable_widgets/expandable_textBox.dart';
import 'package:service_application/globals.dart' as global;
import 'package:service_application/utils/stringUtils.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/store/actions.dart';
import 'package:service_application/error_management/error_messages.dart'
    as ErrorMessage;

class FeedItemConatiner extends StatelessWidget {
  final Event event;
  final int numberOfLinesOnMinimized;

  FeedItemConatiner({Key key, this.event, this.numberOfLinesOnMinimized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, event);
      },
      builder: (context, vm) {
        return FeedItem(
          startDate:
              "${event.startDate.year}-${event.startDate.month}-${event.startDate.day}",
          title: event.title,
          details: event.details,
          imageUrl: event.imageUrl,
          numberOfLinesOnMinimized: numberOfLinesOnMinimized,
          onEventSelected: vm.onEventSelected,
        );
      },
    );
  }
}

class FeedItem extends StatefulWidget {
  FeedItem({
    Key key,
    this.title,
    this.startDate,
    this.imageUrl,
    this.details,
    this.numberOfLinesOnMinimized,
    this.onEventSelected,
  }) : super(key: key);

  final String title;
  final String startDate;
  final String imageUrl;
  final String details;
  final int numberOfLinesOnMinimized;
  final Function onEventSelected;

  @override
  _FeedItemState createState() => new _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _expanded = false;

  void _onEventSelected() {
    this._toggleExpansion();
    try {
      widget.onEventSelected();
    } on NoSuchMethodError {
      print(ErrorMessage.STORELESS_COMPONENT_WITH_UNDEFINED_VIEWMODEL_FUNCTION);
    }
  }

  void _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Feed Item Expanded: " + '$_expanded');

    Widget feedItem = new Card(
      margin: _expanded
          ? const EdgeInsets.only(
              left: global.marginpaddingFromScreenHover,
              right: global.marginpaddingFromScreenHover,
              top: 0.0,
              bottom: 15.0)
          : const EdgeInsets.only(
              left: global.marginpaddingFromScreenFlat,
              right: global.marginpaddingFromScreenFlat,
              top: 0.0,
              bottom: 20.0),
      elevation: _expanded ? global.cardHover : global.cardResting,
      clipBehavior: Clip.antiAlias,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(global.boxborderRadius),
      ),
      child: InkWell(
        onTap: _onEventSelected,
        child: Container(
          padding: const EdgeInsets.all(global.paddingFromWalls),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Date and chevron icon row
              new Row(
                children: <Widget>[
                  Expanded(
                    child: ifEmptyOrNull(widget.startDate)
                        ? new Padding(
                            padding: EdgeInsets.all(global.dividerPadding),
                          )
                        : new Text(
                            widget.startDate,
                            style: Theme.of(context).textTheme.body1,
                          ), // if there's no date, replace with blank spacing
                  ),
                  new Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: global.iconSize,
                  )
                ],
              ),
              // Header
              ifEmptyOrNull(widget.title)
                  ? null
                  : new Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline,
                    ),
              // Details
              ifEmptyOrNull(widget.details)
                  ? null
                  : new ExpandableTextBox(
                      text: widget.details,
                      numberOfMinimalLines:
                          widget.numberOfLinesOnMinimized ?? 4,
                      expanded: _expanded,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
              // Blank spacing
              new Padding(
                padding: EdgeInsets.all(global.dividerPadding),
              ),
              // Event image
              ifEmptyOrNull(widget.imageUrl)
                  ? null
                  : new ExpandableImage(
                      imageUrl: widget.imageUrl,
                      height: global.imageHeightStandard,
                    ),
            ].where(notNull).toList(),
          ),
        ),
      ),
    );

    return new ExpansionCrossFade(
        collapsed: feedItem, expanded: feedItem, isExpanded: _expanded);
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
