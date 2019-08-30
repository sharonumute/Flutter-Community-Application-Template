import 'package:flutter/material.dart';
import 'package:service_application/Components/CustomImage.dart';
import 'package:service_application/Globals/Values.dart';
import "package:service_application/Utils/DataUtils.dart";
import 'package:service_application/Utils/WidgetUtils.dart';

/// Create a circular persona object that expands to show
/// Full persona information on click
///
/// `person`: Person object containing all necessary details
///
/// `diameter`: Diameter of the circular avatar
class PersonaCoin extends StatelessWidget {
  PersonaCoin({Key key, this.person, this.diameter = 40.0}) : super(key: key);

  final Person person;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    void _showPersonaInfo() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Center(
              child: new Column(
                children: <Widget>[
                  returnCircleWidget(
                    new CustomImage(
                      imageUrl: person.imageUrl,
                      height: 80,
                      width: 80,
                      imageFallbackType: FallbackType.textboy,
                      imageFallbackTextboyText: person.name,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(dividerPadding),
                  ),
                  new Text(person.name),
                ],
              ),
            ),
            contentPadding:
                const EdgeInsets.fromLTRB(dialog, (dialog / 2), dialog, 0),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text(person.personInformation),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return new Container(
      margin: const EdgeInsets.only(right: marginForAvatarImages),
      child: returnCircleWidget(
        new CustomImage(
          imageUrl: person.imageUrl,
          height: diameter,
          width: diameter,
          imageFallbackType: FallbackType.textboy,
          imageFallbackTextboyText: person.name,
          onClick: _showPersonaInfo,
        ),
      ),
    );
  }
}
