import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 60,
        height: 35,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? AppColors.primary : AppColors.onBackgroundSurface3,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
