import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';

class ChatCircleAvatar extends StatelessWidget {
  const ChatCircleAvatar({
    Key? key,
    required this.avatar,
    this.onlineDotSize = 15.0,
    this.imgSize = 60.0,
  }) : super(key: key);
  final String avatar;
  final double imgSize;
  final double onlineDotSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipOval(
          child: SizedBox(
            height: imgSize,
            width: imgSize,
            child: CachedNetworkImage(
              imageUrl: avatar,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SvgPicture.asset(
          AppAsset.icOnlineCircle,
          height: onlineDotSize,
          width: onlineDotSize,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
