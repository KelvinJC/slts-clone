import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isGradient;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isGradient = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var gradient = !isLoading
        ? AppColors.buttonGradient
        : AppColors.buttonGradient.map((e) => e.withAlpha(100)).toList();
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  ///if is loading reduce color
                  colors: gradient,
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
