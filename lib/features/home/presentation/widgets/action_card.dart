import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class ActionCard extends StatelessWidget {
  final String asset;
  final String label;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.asset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: wp(44),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(wp(2)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: wp(7),
              backgroundColor: AppColors.onBackgroundSurface3,
              child: ImageIcon(
                AssetImage(asset),
                size: wp(
                  asset == AppAssets.createJob ? 6 : 6.5,
                ), // adjust as needed
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: hp(1.5)),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
