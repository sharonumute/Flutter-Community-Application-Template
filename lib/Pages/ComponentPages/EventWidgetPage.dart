import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:community_application/Components/ImageWidget.dart';
import 'package:community_application/Components/TextWidget.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Models/Event.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

/// Page of event content, when an event widget is clicked
class EventWidgetPage extends StatelessWidget {
  EventWidgetPage({
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
                background: ImageWidget(
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
            new TextWidget(
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
