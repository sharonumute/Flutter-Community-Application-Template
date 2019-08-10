import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';
import "package:service_application/Utils/DataUtils.dart";

/// Create a circular persona object that expands to show
/// Full persona information on click
///
/// `person`: Person object containing all necessary details
///
/// `diameter`: Diameter of the circular avatar
class Persona extends StatelessWidget {
  Persona({Key key, this.person, this.diameter = 40.0}) : super(key: key);

  final Person person;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(right: marginForAvatarImages),
      child: new Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: Ink.image(
          image: new NetworkImage(person.imageUrl),
          fit: BoxFit.cover,
          height: diameter,
          width: diameter,
          child: InkWell(),
        ),
      ),
    );
  }
}
