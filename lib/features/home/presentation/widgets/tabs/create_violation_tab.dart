import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class CreateViolationTab extends StatelessWidget {
  const CreateViolationTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with your real Create Violation UI
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.homeGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(child: Text('Create Violation')),
    );
  }
}
