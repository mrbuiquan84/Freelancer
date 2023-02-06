import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/utils/helpers/check_img_url.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppCircleAvatar extends StatefulWidget {
  const AppCircleAvatar({
    Key? key,
    this.imgSize = kCardCircleAvatarSized,
    this.avatar,
    this.nonAvatarAsset = AppAsset.imgColoredNonAvatar,
    this.errorImageAsset = AppAsset.imgNonAvatar,
  }) : super(key: key);
  final double imgSize;
  final String? avatar;
  final String nonAvatarAsset;
  final String errorImageAsset;

  @override
  State<AppCircleAvatar> createState() => _AppCircleAvatarState();
}

class _AppCircleAvatarState extends State<AppCircleAvatar> {
  late final Future<bool> _checkUrl;

  @override
  void initState() {
    _checkUrl = checkImgUrl(widget.avatar ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildImage() {
      var errorImg = Image.asset(
        widget.nonAvatarAsset,
        fit: BoxFit.cover,
        height: widget.imgSize,
        width: widget.imgSize,
      );
      try {
        return FutureBuilder<bool>(
            future: _checkUrl,
            builder: (context, snapshot) {
              return ClipOval(
                child:
                    widget.avatar != null && snapshot.hasData && snapshot.data!
                        ? CachedNetworkImage(
                            imageUrl: widget.avatar!,
                            fit: BoxFit.cover,
                            height: widget.imgSize,
                            width: widget.imgSize,
                            placeholder: (_, __) =>
                                Image.asset(widget.errorImageAsset),
                            errorWidget: (_, __, e) {
                              return Image.asset(widget.errorImageAsset);
                            },
                          )
                        : Image.asset(
                            widget.nonAvatarAsset,
                            height: widget.imgSize,
                            width: widget.imgSize,
                            fit: BoxFit.cover,
                          ),
              );
            });
      } catch (_) {
        return errorImg;
      }
    }

    return buildImage();
  }
}
