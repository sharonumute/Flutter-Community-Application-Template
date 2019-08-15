import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';

/// Create an image object that expands on click/tap
///
/// `image`: The content image url
///
/// `height`: Height of object when minimized, parent control width
///
/// `width`: Width of object when minimized, if undefined, parent control width
class ExpandableImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  ExpandableImage({Key key, this.imageUrl, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _previewImage() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return new Scaffold(
              appBar: new AppBar(
                backgroundColor: dafaultBlack,
              ),
              body: new Center(
                child: Image.network(imageUrl),
              ),
              backgroundColor: dafaultBlack,
            );
          },
        ),
      );
    }

    return new SizedBox(
      height: height,
      width: width,
      child: new Material(
        borderRadius: new BorderRadius.circular(boxborderRadius),
        clipBehavior: Clip.hardEdge,
        child: Ink.image(
          image: new NetworkImage(imageUrl),
          fit: BoxFit.fitWidth,
          height: height,
          child: InkWell(
            onTap: _previewImage,
          ),
        ),
      ),
    );
  }
}
