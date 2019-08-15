import 'package:flutter/material.dart';

Widget returnCircleImage(Widget image) {
  return new Material(
    shape: CircleBorder(),
    clipBehavior: Clip.hardEdge,
    child: image,
  );
}
