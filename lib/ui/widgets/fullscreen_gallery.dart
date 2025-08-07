import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final Color backgroundColor;
  final Color indicatorColor;
  final Color indicatorBackgroundColor;

  const FullScreenGallery({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.backgroundColor = Colors.black,
    this.indicatorColor = Colors.white,
    this.indicatorBackgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: imageUrls.length,
            builder: (ctx, idx) => PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(imageUrls[idx]),
            ),
            scrollPhysics: const BouncingScrollPhysics(),
            loadingBuilder: (ctx, event) => Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: indicatorColor,
                  backgroundColor: indicatorBackgroundColor,
                  value: event == null
                      ? null
                      : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
            backgroundDecoration: BoxDecoration(color: backgroundColor),
            pageController: PageController(initialPage: initialIndex),
          ),

          // “Back” button in the top left
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: indicatorColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
