import 'package:flutter/material.dart';
import './expandable_textBox.dart';
import './persona.dart';
import '../globals.dart' as global;
import '../utils/stringUtils.dart';
import '../utils/widgetUtils.dart';

class SermonItem extends StatelessWidget {
  SermonItem(
      {Key key,
      this.title,
      this.date,
      this.preacher,
      this.sermon,
      this.numberOfLinesOnMinimized = 2})
      : super(key: key);

  final String title;
  final String date;
  final Person preacher;
  final String sermon;
  final int numberOfLinesOnMinimized;

  @override
  Widget build(BuildContext context) {
    void _openSermon() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return new Scaffold(
                appBar: new AppBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context).backgroundColor,
                  iconTheme: Theme.of(context).iconTheme,
                ),
                body: new ListView(
                  padding: const EdgeInsets.all(global.paddingFromScreen),
                  children: <Widget>[
                    new Text(
                      title,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(global.dividerPadding),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Persona(
                              person: preacher,
                              diameter: 20.0,
                            ),
                            new Text(
                              preacher.name,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ],
                        ),
                        new Text(
                          date,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    new Padding(
                      padding: EdgeInsets.all(global.dividerPadding * 2),
                    ),
                    new ExpandableTextBox(
                      text: sermon,
                      expanded: true,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ));
          },
        ),
      );
    }

    return new Card(
      margin: const EdgeInsets.all(global.marginpaddingFromScreenTop),
      elevation: global.cardResting,
      clipBehavior: Clip.hardEdge,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(global.boxborderRadius),
      ),
      child: InkWell(
        onTap: _openSermon,
        child: Container(
          padding: const EdgeInsets.all(global.paddingFromWalls),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                title,
                style: Theme.of(context).textTheme.headline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              new Padding(
                padding: EdgeInsets.all(global.dividerPadding / 2),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Persona(person: preacher, diameter: 20.0),
                      new Text(
                        preacher.name,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                  new Text(
                    date,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              new Padding(
                padding: EdgeInsets.all(global.dividerPadding),
              ),
              // sermon
              ifEmptyOrNull(sermon)
                  ? null
                  : new ExpandableTextBox(
                      text: sermon,
                      numberOfMinimalLines: numberOfLinesOnMinimized ?? 2,
                      expanded: false,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
            ].where(notNull).toList(),
          ),
        ),
      ),
    );
  }
}
