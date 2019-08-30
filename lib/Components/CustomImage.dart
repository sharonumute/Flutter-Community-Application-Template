import 'package:flutter/material.dart';
import 'package:service_application/Globals/Values.dart';
import 'package:service_application/Utils/CommonUtils.dart';
import 'package:service_application/Pages/ComponentPages/CustomImagePage.dart';
import 'package:service_application/Utils/StringUtils.dart';
import 'package:service_application/Utils/WidgetUtils.dart';

enum FallbackType { color, image, textboy }

/// Create an image object that expands on click/tap
///
/// `image`: The content image url

/// `height`: Height of object when minimized, parent control width
///
/// `width`: Width of object when minimized, if undefined, parent control width
class CustomImage extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;
  final bool tint;
  final FallbackType imageFallbackType;
  final Color imageFallbackColor;
  final String imageFallbackFilename;
  final String imageFallbackTextboyText;
  final void Function() onClick;

  CustomImage(
      {Key key,
      this.imageUrl,
      this.height,
      this.width,
      this.tint,
      this.imageFallbackType,
      this.imageFallbackColor,
      this.imageFallbackFilename,
      this.imageFallbackTextboyText,
      this.onClick})
      : super(key: key);

  @override
  _CustomImageState createState() => new _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  bool imageFailedToLoad = false;

  @override
  Widget build(BuildContext context) {
    void _previewImage() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return ExpandableImagePage(imageUrl: widget.imageUrl);
          },
        ),
      );
    }

    bool showTint = ifObjectIsNotNull(widget.tint) ? widget.tint : false;

    NetworkImage networkImage = NetworkImage(widget.imageUrl);

    precacheImage(networkImage, context, onError: (e, stackTrace) {
      print("Image ${widget.imageUrl} failed to load with error $e.");
      setState(() {
        imageFailedToLoad = true;
      });
    });

    Container tintObject = showTint
        ? Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xCC000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                ],
              ),
            ),
          )
        : null;

    Color imageFallbackColor = widget.imageFallbackColor ?? getRandomColor();

    Widget getImageFallback(FallbackType fallbackType) {
      switch (fallbackType) {
        case FallbackType.color:
          return new Container(
            color: imageFallbackColor,
            height: widget.height,
            width: widget.width,
            child: InkWell(
              onTap: widget.onClick ?? _previewImage,
            ),
          );
        case FallbackType.image:
          return new Container(
            color: imageFallbackColor,
            height: widget.height,
            width: widget.width,
            child: InkWell(
              onTap: widget.onClick ?? _previewImage,
            ),
          );
        case FallbackType.textboy:
          return new Container(
            color: imageFallbackColor,
            height: widget.height,
            width: widget.width,
            child: InkWell(
              child: FittedBox(
                fit: BoxFit.contain,
                child: new Padding(
                  padding: const EdgeInsets.all(marginForAvatarImages),
                  child: new Text(
                    getInitials(widget.imageFallbackTextboyText),
                  ),
                ),
              ),
              onTap: widget.onClick ?? _previewImage,
            ),
          );
        default:
          return null;
      }
    }

    Widget imageObject = imageFailedToLoad
        ? getImageFallback(widget.imageFallbackType)
        : new SizedBox(
            height: widget.height,
            width: widget.width,
            child: new Material(
              clipBehavior: Clip.hardEdge,
              child: Ink.image(
                image: networkImage,
                fit: BoxFit.cover,
                height: widget.height,
                width: widget.width,
                child: InkWell(
                  onTap: widget.onClick ?? _previewImage,
                ),
              ),
            ),
          );

    return new Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        imageObject,
        tintObject,
      ].where(ifObjectIsNotNull).toList(),
    );
  }
}
