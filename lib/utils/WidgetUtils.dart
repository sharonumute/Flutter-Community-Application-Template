import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';

Widget returnCircleWidget(Widget image, {Color color = Colors.transparent}) {
  return new Material(
    color: color,
    shape: CircleBorder(),
    clipBehavior: Clip.hardEdge,
    child: image,
  );
}

Widget loadingScreen = new Scaffold(
  body: new Center(
    child: new CircularProgressIndicator(),
  ),
);

Widget threePointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding / 2),
);

Widget sixPointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding),
);

Widget twelvePointPadding = new Padding(
  padding: EdgeInsets.all(dividerPadding * 2),
);
Color getRandomColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
      .withOpacity(0.3);
}
