import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;

  const CachedImage({super.key, required this.url, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      imageUrl: url,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.none,
      progressIndicatorBuilder: (context, url, progress) => Container(
        alignment: Alignment.center,
        height: context.hp(6),
        width: context.hp(6),
        child: Platform.isIOS
            ? CupertinoActivityIndicator(color: AppColors.primary30)
            : CircularProgressIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.primary30,
                value: progress.progress,
              ),
      ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, size: context.hp(5), color: AppColors.error),
    );
  }
}
