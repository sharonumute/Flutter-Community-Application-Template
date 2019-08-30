import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:service_application/Components/CustomImage.dart';
import 'package:service_application/Components/CustomText.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Utils/CommonUtils.dart';
import 'package:service_application/Utils/DataUtils.dart';
import 'package:service_application/Utils/DateUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

class EventItemPage extends StatelessWidget {
  EventItemPage({
    Key key,
    this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    List<Widget> dateAndTimeRow = [
      new Text(
        startToEndDate(event.startDate, event.endDate),
        style: Theme.of(context).textTheme.caption,
      ),
      ifObjectIsNotNull(event.startDate) && ifObjectIsNotNull(event.endDate)
          ? new Text(
              "  •  ${startToEndTime(event.startDate, event.endDate)}",
              style: Theme.of(context).textTheme.caption,
            )
          : null,
    ].where(ifObjectIsNotNull).toList();

    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CustomImage(
                  imageUrl: event.imageUrl,
                  height: 150,
                  tint: true,
                  imageFallbackType: FallbackType.color,
                  imageFallbackColor: event.color,
                ),
              ),
            ),
          ];
        },
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(paddingFromScreen),
          children: <Widget>[
            new Text(
              event.title,
              style: Theme.of(context).textTheme.title,
            ),
            threePointPadding,
            new Row(
              children: dateAndTimeRow,
            ),
            sixPointPadding,
            new CustomText(
              text: event.details,
              expanded: true,
              textStyle: Theme.of(context).textTheme.body2,
            ),
          ],
        ),
      ),
    );
  }
}
