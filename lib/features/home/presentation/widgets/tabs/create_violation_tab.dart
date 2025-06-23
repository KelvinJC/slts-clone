import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';

class CreateViolationTab extends StatelessWidget {
  const CreateViolationTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with your real Create Violation UI
    return Stack(
      children: [
        BlurryGradientBackground(colors: AppColors.homeGradient),
        const Center(child: Text('Create Violation')),
      ],
    );
  }
}
