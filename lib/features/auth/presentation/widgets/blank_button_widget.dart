import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class BlankButton extends StatelessWidget {
  final String text;

  const BlankButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: wp(3)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(wp(2)),
        border: Border.all(color: AppColors.onBackgroundSurface2, width: wp(0.4)),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.onBackgroundSurface2,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}


