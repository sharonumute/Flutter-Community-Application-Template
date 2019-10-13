import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:community_application/Components/TextWidget.dart';
import 'package:community_application/Components/PersonaCoin.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Models/Person.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

/// Page of article content, when an article widget is clicked
class ArticleWidgetPage extends StatelessWidget {
  ArticleWidgetPage({
    Key key,
    this.title,
    this.date,
    this.author,
    this.article,
  }) : super(key: key);

  final String title;
  final DateTime date;
  final Person author;
  final String article;

  @override
  Widget build(BuildContext context) {
    Widget personaAndDateRow = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new PersonaCoin(
              person: author,
              diameter: 20.0,
            ),
            new Text(
              author.name,
              style: Theme.of(context).textTheme.body2,
            ),
          ],
        ),
        new Text(
          "${presentationFullDayFormat(date)}",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: new ListView(
        padding: const EdgeInsets.all(paddingFromScreen),
        children: <Widget>[
          new Text(
            title,
            style: Theme.of(context).textTheme.display1,
          ),
          sixPointPadding,
          personaAndDateRow,
          twelvePointPadding,
          new TextWidget(
            text: article,
            expanded: true,
            textStyle: Theme.of(context).textTheme.body2,
          ),
        ],
      ),
    );
  }
}
