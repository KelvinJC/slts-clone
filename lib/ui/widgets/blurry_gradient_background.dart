import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable widget that displays two blurred color blobs over a gradient.
class BlurryGradientBackground extends StatelessWidget {
  /// The two base colors to blend.
  final List<Color> colors;

  const BlurryGradientBackground({super.key, required this.colors})
    : assert(colors.length == 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          // 1) Your two colored “blobs” (e.g. circles or rectangles)
          Positioned(
            top: 100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: colors[0],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: colors[1],
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 2) The blur layer
          //    ClipRect scopes the blur to the whole screen
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5000, sigmaY: 5000),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage in ProfileTab:

// import 'blurry_background.dart';
//
// class ProfileTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const BlurryGradientBackground(
//           colors: AppColors.homeGradient,
//           // optionally customize alignment and sizes:
//           // topBlobAlignment: Alignment(1.0, -1.0),
//           // bottomBlobAlignment: Alignment(-1.0, 1.0),
//         ),
//         Center(child: Text('Profile Screen')),
//       ],
//     );
//   }
// }
