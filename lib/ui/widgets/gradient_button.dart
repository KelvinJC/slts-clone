import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isGradient;

  const GradientButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  colors: AppColors.buttonGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isGradient ? null : Colors.transparent,
          border: isGradient
              ? null
              : Border.all(color: AppColors.onBackgroundSurface2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: child),
      ),
    );
  }
}
