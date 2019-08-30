import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Utils/DateUtils.dart';

class WidgetMonthYearBucket extends StatelessWidget {
  final List<Widget> items;
  final DateTime date;

  WidgetMonthYearBucket({
    Key key,
    @required this.items,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsInThisBucket = [];

    /// Add Month Year Indicator
    itemsInThisBucket.add(
      new Text(
        formatMonth(date),
        style: Theme.of(context).textTheme.body2,
        textAlign: TextAlign.left,
      ),
    );

    for (Widget item in items) {
      itemsInThisBucket.add(
        item,
      );
    }

    return new Card(
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: paddingFromScreen),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: new Container(
        child: new Column(
          children: itemsInThisBucket,
        ),
      ),
    );
  }
}
