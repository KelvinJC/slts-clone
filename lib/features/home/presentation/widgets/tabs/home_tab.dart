import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/responsive_table.dart';

import '../action_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final avatarSize = wp(14);

    return Stack(
      children: [
        BlurryGradientBackground(colors: AppColors.homeGradient),
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: wp(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: hp(3)),
                // … reuse your _buildTopBar from earlier or inline …
                _buildTopBar(context, wp, hp, avatarSize, wp(0.5)),
                SizedBox(height: hp(4)),
                AppTextField(
                  hintText: 'Run plate number...',
                  readOnly: true,
                  showSearchIcon: true,
                  onTap: () => Navigator.pushNamed(context, '/search'),
                ),
                SizedBox(height: hp(3.5)),
                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        asset: AppAssets.patrol,
                        label: 'Patrol Mode',
                        onTap: () => {
                          // Navigator.pushNamed(context, '/patrol');
                        },
                      ),
                    ),
                    SizedBox(width: wp(5)),
                    Expanded(
                      child: ActionCard(
                        asset: AppAssets.violation,
                        label: 'Violation Report',
                        onTap: () => {
                          // Navigator.pushNamed(context, '/createViolation');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hp(1)),
                _buildRecentHeader(context, wp, hp),
                Expanded(child: _buildEmptyState(context, hp, wp)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
    double avatarSize,
    double border,
  ) {
    int notiSum = 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              padding: EdgeInsets.all(border),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.homeGradient[0],
                radius: (avatarSize - 2 * border) / 2,
                backgroundImage: const AssetImage(AppAssets.avatar),
              ),
            ),
            SizedBox(width: wp(3)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(ctx).textTheme.titleMedium!.copyWith(
                    color: AppColors.onBackgroundSurface,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Oyewumi Olukunle',
                  style: Theme.of(ctx).textTheme.headlineSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Stack(
              children: [
                ImageIcon(AssetImage(AppAssets.notification), size: wp(6)),
                Visibility(
                  visible: true,
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: wp(notiSum > 9 ? 4.5 : 3.5),
                      height: wp(4.2),
                      decoration: const BoxDecoration(
                        color: AppColors.notification,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          notiSum > 9 ? '9+' : notiSum.toString(),
                          style: Theme.of(ctx).textTheme.labelSmall!.copyWith(
                            fontSize: wp(notiSum > 9 ? 2.5 : 2.2),
                            color: AppColors.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildRecentHeader(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Captures',
          style: Theme.of(
            ctx,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(ctx, '/recentCaptures'),
          child: Text(
            'View all',
            style: Theme.of(ctx).textTheme.bodySmall!.copyWith(
              color: AppColors.onBackgroundSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext ctx,
    double Function(double) hp,
    double Function(double) wp,
  ) {
    bool hasData = true;
    // Sample data
    final headers = [
      const Text('PCN Number'),
      const Text('Plate Number'),
      const Text('Offence'),
      const Text('Amount'),
      const Text('Name'),
      const Text('Age'),
      const Text('Role'),
      const Text('Status'),
    ];
    final rows = [
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Alice'),
        const Text('28'),
        const Text('Admin'),
        const Text('Active'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Bob'),
        const Text('34'),
        const Text('Director'),
        const Text('Pending'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Charlie'),
        const Text('22'),
        const Text('Nurse'),
        const Text('Active'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
    ];
    return Stack(
      children: [
        hasData
            ? HtmlTable(
                headers: headers,
                rows: rows,
                columnWidths: [
                  FixedColumnWidth(wp(30)),
                  FixedColumnWidth(wp(30)),
                  FixedColumnWidth(wp(30)),
                  FixedColumnWidth(wp(30)),
                  IntrinsicColumnWidth(),
                  FixedColumnWidth(80),
                  FixedColumnWidth(wp(30)),
                  FixedColumnWidth(wp(30)),
                ],
                borderRadius: BorderRadius.circular(12),
                outerBorderColor: AppColors.onBackgroundSurface2,
                innerBorderColor: AppColors.onBackgroundSurface2,
                // cellWidth: 100,
                rowHeight: hp(3.5),
                cellPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                maxVisibleRows: 3,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Media capture yet',
                      style: Theme.of(ctx).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                      'Once there is capture, we would\nupdate it here...',
                      textAlign: TextAlign.center,
                      style: Theme.of(ctx).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
        Positioned(
          right: 0,
          bottom: 15,
          child: Container(
            padding: EdgeInsets.all(ctx.wp(1)),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.homeGradient[1]),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: AppColors.buttonGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              blendMode: BlendMode.srcIn,
              child: IconButton(
                icon: ImageIcon(AssetImage(AppAssets.camera), size: ctx.wp(8)),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
