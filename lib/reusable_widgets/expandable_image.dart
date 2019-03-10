import 'package:flutter/material.dart';
import 'package:service_application/globals.dart' as globals;

/// Create an image object that expands on click/tap
///
/// `image`: The content image url
///
/// `height`: Height of object when minimized, parent control width
class ExpandableImage extends StatelessWidget {
  ExpandableImage({Key key, this.imageUrl, this.height}) : super(key: key);

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    void _previewImage() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return new Scaffold(
              appBar: new AppBar(
                backgroundColor: globals.dafaultBlack,
              ),
              body: new Center(
                child: Image.network(imageUrl),
              ),
              backgroundColor: globals.dafaultBlack,
            );
          },
        ),
      );
    }

    return new Material(
      borderRadius: new BorderRadius.circular(globals.boxborderRadius),
      clipBehavior: Clip.hardEdge,
      child: Ink.image(
        image: new NetworkImage(imageUrl),
        fit: BoxFit.fitWidth,
        height: height,
        child: InkWell(
          onTap: _previewImage,
        ),
      ),
    );
  }
}
