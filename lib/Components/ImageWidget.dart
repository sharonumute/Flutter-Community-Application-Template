import 'package:flutter/material.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Pages/ComponentPages/ImageWidgetPage.dart';
import 'package:community_application/Utils/StringUtils.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

enum FallbackType { color, image, textboy }

/// Create an image object that
/// - Expands on click/tap
/// - Can possess a bottom shadow effect: `tint?`
/// - Can use a fallback image: `imageFallbackFilename`
/// - Can use a fallback color: `imageFallbackColor`
/// - Can use a fallback textboy: `imageFallbackTextboyText`
///
/// `image`: The content image url
///
/// `height`: Height of object when minimized, parent control width
///
/// `width`: Width of object when minimized, if undefined, parent control width
///
/// `imageFallbackType`: Specify the image widget's fallback type: `color` or `image` or`textboy`
class ImageWidget extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;
  final bool tint;
  final FallbackType imageFallbackType;
  final Color imageFallbackColor;
  final String imageFallbackFilename;
  final String imageFallbackTextboyText;
  final void Function() onClick;

  ImageWidget(
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
  _ImageWidgetState createState() => new _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool imageLoaded = false;
  Image networkImage;

  @override
  void initState() {
    super.initState();

    setState(() {
      networkImage = Image.network(widget.imageUrl);
    });

    ImageStreamListener imageLoading = ImageStreamListener((i, b) {
      if (mounted) {
        setState(() {
          imageLoaded = true;
        });
      }
    }, onError: (d, s) {
      debugPrint("Image ${widget.imageUrl} failed to load");
      setState(() {
        imageLoaded = false;
      });
    });
    networkImage.image.resolve(ImageConfiguration()).addListener(imageLoading);
  }

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

    Container tintObject = showTint
        ? Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    const Color(0xdd000000),
                    const Color(0x00000000),
                  ]),
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
              onTap: widget.onClick,
            ),
          );
        case FallbackType.image:
          return new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: new AssetImage(widget.imageFallbackFilename),
                fit: BoxFit.cover,
              ),
            ),
            height: widget.height,
            width: widget.width,
            child: InkWell(
              onTap: widget.onClick,
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
              onTap: widget.onClick,
            ),
          );
        default:
          return null;
      }
    }

    Widget imageObject = imageLoaded
        ? new SizedBox(
            height: widget.height,
            width: widget.width,
            child: new Material(
              clipBehavior: Clip.hardEdge,
              child: Ink.image(
                image: networkImage.image,
                fit: BoxFit.cover,
                height: widget.height,
                width: widget.width,
                child: InkWell(
                  onTap: widget.onClick ?? _previewImage,
                ),
              ),
            ),
          )
        : getImageFallback(widget.imageFallbackType);

    return new Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        imageObject,
        tintObject,
      ].where(ifObjectIsNotNull).toList(),
    );
  }
}
