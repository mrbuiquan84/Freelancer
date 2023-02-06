import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/utils/helpers/check_img_url.dart';

class AppNetworkImage extends StatefulWidget {
  const AppNetworkImage({
    Key? key,
    this.imageUrl,
    this.errorWidget,
    this.placeHolder,
    this.imgSize,
  }) : super(key: key);
  final String? imageUrl;
  final Widget? errorWidget;
  final Widget? placeHolder;
  final double? imgSize;

  @override
  AppNetworkImageState createState() => AppNetworkImageState();
}

class AppNetworkImageState extends State<AppNetworkImage> {
  late final Future<bool> _checkUrl;
  late final Widget errorWidget;
  late final Widget placeholderWidget;

  @override
  void initState() {
    super.initState();
    _checkUrl = checkImgUrl(widget.imageUrl ?? '');
    errorWidget =
        widget.errorWidget ?? SizedBox.square(dimension: widget.imgSize);
    placeholderWidget = widget.placeHolder ?? errorWidget;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder<bool>(
          future: _checkUrl,
          builder: (context, snapshot) {
            if (widget.imageUrl != null && snapshot.hasData) {
              return snapshot.data!
                  ? CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    fit: BoxFit.cover,
                    height: widget.imgSize,
                    width: widget.imgSize,
                    errorWidget: (_, __, e) {
                      return errorWidget;
                    },
                  )
                  : errorWidget;
            } else {
              return placeholderWidget;
            }
          });
    } catch (_) {
      return errorWidget;
    }
  }
}
