import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class ProfileField extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const ProfileField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(2)),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: wp(6),
            color: AppColors.onBackground,
          ),
          SizedBox(width: wp(4)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.onBackgroundSurface,
                    fontSize: wp(3.2),
                  ),
                ),
                SizedBox(height: hp(0.5)),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
