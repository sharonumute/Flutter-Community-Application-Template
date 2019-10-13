import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:community_application/Globals/Values.dart';

/// Image preview page when an image widget is clicked
class ExpandableImagePage extends StatelessWidget {
  ExpandableImagePage({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: dafaultBlack,
      ),
      body: new Center(
        child: Image.network(imageUrl),
      ),
      backgroundColor: dafaultBlack,
    );
  }
}
