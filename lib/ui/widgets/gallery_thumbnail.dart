import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/fullscreen_gallery.dart';

class GalleryThumbnail extends StatelessWidget {
  final List<String> imageUrls;
  final int index;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? progressColor;
  final Color? progressBgColor;
  final double errorIconSize;

  const GalleryThumbnail({
    super.key,
    required this.imageUrls,
    required this.index,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.progressColor,
    this.progressBgColor,
    this.errorIconSize = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrls[index];
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenGallery(
            imageUrls: imageUrls,
            initialIndex: index,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            indicatorColor: progressColor ?? AppColors.primary30,
            indicatorBackgroundColor: progressBgColor ?? Colors.black26,
          ),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        progressIndicatorBuilder: (_, __, progress) => Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: progressColor ?? AppColors.primary30,
              backgroundColor: progressBgColor ?? Colors.black26,
              value: progress.progress,
            ),
          ),
        ),
        errorWidget: (_, __, ___) =>
            Icon(Icons.error, size: errorIconSize, color: AppColors.error),
      ),
    );
  }
}
