import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/custom_toggle_switch.dart';

/// Simple data class for each setting row.
class SettingItemData {
  final String icon; // path from AppAssets
  final String label;
  final VoidCallback onTap;
  final void Function(bool)? onSwitchChanged;
  final bool? isSwitchOn;

  SettingItemData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.onSwitchChanged,
    this.isSwitchOn,
  });
}

/// A single tappable row with leading icon + text.
class SettingItem extends StatelessWidget {
  final SettingItemData data;

  const SettingItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(wp(1)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(1.8), horizontal: wp(3)),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(data.icon),
              size: wp(5),
              color: AppColors.onBackground,
            ),
            SizedBox(width: wp(4)),
            Expanded(
              child: Text(
                data.label,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppColors.onBackground),
              ),
            ),
            if (data.label == '2FA' &&
                data.onSwitchChanged != null &&
                data.isSwitchOn != null)
              // Switch(value: data.isSwitchOn!, onChanged: data.onSwitchChanged!),
              CustomToggleSwitch(
                value: data.isSwitchOn!,
                onChanged: data.onSwitchChanged!,
              ),
          ],
        ),
      ),
    );
  }
}
