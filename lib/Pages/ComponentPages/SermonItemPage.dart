import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:service_application/Components/CustomText.dart';
import 'package:service_application/Components/PersonaCoin.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

class SermonItemPage extends StatelessWidget {
  SermonItemPage({
    Key key,
    this.title,
    this.date,
    this.preacher,
    this.sermon,
  }) : super(key: key);

  final String title;
  final DateTime date;
  final Person preacher;
  final String sermon;

  @override
  Widget build(BuildContext context) {
    Widget personaAndDateRow = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new PersonaCoin(
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
          new CustomText(
            text: sermon,
            expanded: true,
            textStyle: Theme.of(context).textTheme.body2,
          ),
        ],
      ),
    );
  }
}
