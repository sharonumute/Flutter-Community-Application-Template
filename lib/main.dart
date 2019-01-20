import 'package:flutter/material.dart';
import 'reusable_widgets/expandable_image.dart';
import 'reusable_widgets/expandable_textBox.dart';
import 'reusable_widgets/feed_item.dart';
import 'reusable_widgets/sermon_item.dart';
import 'reusable_widgets/persona.dart';
import './importedWidgets/flutter_calendar.dart';
import './utils/widgetUtils.dart';
import './themes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String sampleTitle =
        "Serving the lord with all your heart with all your mind and everything";
    String sampleImageUrl =
        "https://www.gettyimages.ca/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg";
    String sampleLongText =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus posuere urna ut nibh tempor aliquet. Etiam enim ante, maximus ac placerat ac, vehicula vel nulla. Aliquam risus dolor, mollis ut nisi sit amet, sodales dapibus eros. Etiam a velit diam. Fusce imperdiet quam sit amet congue ornare. Proin mollis tempus consequat. Morbi ut tristique felis, ullamcorper auctor dolor. Phasellus mattis odio sed lorem aliquet tincidunt. Donec elementum commodo vehicula. Aenean nec placerat urna. Curabitur accumsan nulla nec tempor aliquam. Maecenas ultrices urna urna.";

    Map<DateTime, Event> sampleEvents = new Map<DateTime, Event>();
    sampleEvents[new DateTime(2018, 12, 30)] = new Event(
        new DateTime(2018, 12, 30),
        new DateTime.now(),
        sampleTitle,
        sampleLongText,
        sampleImageUrl,
        Colors.green);
    sampleEvents[new DateTime(2018, 12, 1)] = new Event(
        new DateTime(2018, 12, 1),
        new DateTime.now(),
        sampleTitle,
        sampleLongText,
        sampleImageUrl,
        Colors.red);
    sampleEvents[new DateTime(2018, 12, 10)] = new Event(
        new DateTime(2018, 12, 10),
        new DateTime.now(),
        sampleTitle,
        sampleLongText,
        sampleImageUrl,
        Colors.black);
    Person samplePerson =
        new Person("Mavis Baywin", sampleImageUrl, sampleLongText);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical, //TODO make scroll
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* new FeedItem(
              startDate: "Jan 01",
              title: sampleTitle,
              details: sampleLongText,
              imageUrl: sampleImageUrl,
            ),*/
            new Calendar(
              isExpandable: true,
              /*onDateSelected: (date) => onDatePressed,*/
              events: sampleEvents,
            ),
            new SermonItem(
                title: sampleTitle,
                preacher: samplePerson,
                sermon: sampleLongText,
                date: "January 5 2019")
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
