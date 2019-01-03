import 'package:flutter/material.dart';
import './expandable_image.dart';
import './expandable_textBox.dart';
import '../globals.dart' as global;
import '../utils/stringUtils.dart';
import '../utils/widgetUtils.dart';

class FeedItem extends StatefulWidget {
  FeedItem({Key key, this.title, this.startDate, this.imageUrl, this.details})
      : super(key: key);

  final String title;
  final String startDate;
  final String imageUrl;
  final String details;

  @override
  _FeedItemState createState() => new _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _expanded = false;

  void _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Feed Item Expanded: " + '$_expanded');

    Widget feedItem = new Card(
      margin: const EdgeInsets.all(4.0),
      elevation: 1.0,
      clipBehavior: Clip.hardEdge,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(global.boxborderRadius),
      ),
      child: InkWell(
        onTap: _toggleExpansion,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Expanded(
                    child: ifEmptyOrNull(widget.startDate)
                        ? new Padding(
                            padding: EdgeInsets.all(6.0),
                          )
                        : new Text(
                            widget.startDate,
                            style: Theme.of(context).textTheme.body1,
                          ),
                  ),
                  new Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: global.iconSize,
                  )
                ],
              ),
              ifEmptyOrNull(widget.title)
                  ? null
                  : new Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline,
                    ),
              ifEmptyOrNull(widget.details)
                  ? null
                  : new ExpandableTextBox(
                      text: widget.details,
                      numberOfMinimalLines: 4,
                      expanded: _expanded,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
              new Padding(
                padding: EdgeInsets.all(6.0),
              ),
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
      collapsed: feedItem,
      expanded: feedItem,
      isExpanded: _expanded,
      flex: 0,
    );
  }
}
