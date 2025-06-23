import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with your real Profile UI
    return Stack(
      children: [
        BlurryGradientBackground(colors: AppColors.homeGradient),
        Center(child: Text('Profile Screen')),
      ],
    );
  }
}
