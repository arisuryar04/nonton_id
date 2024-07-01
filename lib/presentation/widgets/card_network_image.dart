import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/assets.dart';
import '../../core/constant/color.dart';

class CardNetworkImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;

  const CardNetworkImage(
    this.url, {
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: white.withOpacity(0.3),
          borderRadius: borderRadius,
        ),
        child: Image.asset(
          Assets.errorImage,
          height: 50,
          width: 50,
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
        baseColor: white.withOpacity(0.7),
        highlightColor: white.withOpacity(0.8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: white,
          ),
        ),
      ),
    );
  }
}
