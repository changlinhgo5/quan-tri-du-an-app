import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../values/app_images.dart';

class ImageCustom extends StatelessWidget {
  String url = "";
  double? width;
  double? height;
  bool isAvatar;
  double? radius;
  BoxShape? shape;
  ImageCustom({
    Key? key,
    this.url = "",
    this.width,
    this.height,
    this.isAvatar = false,
    this.radius,
    this.shape,
  }) : super(key: UniqueKey());
  String storeImage = "";
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: url.isNotEmpty
          ? Image(
              image: NetworkImage(url),
              width: width,
              height: height,
              fit: BoxFit.fill,
            )
          : Image(
              image: AssetImage(AppImages.iconAvatarDefault),
              width: 42,
              height: 42,
            ),
    );
  }
}
