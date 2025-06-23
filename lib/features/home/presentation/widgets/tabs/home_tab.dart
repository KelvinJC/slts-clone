import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';

import '../action_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final avatarSize = wp(14);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.homeGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hp(3)),
              // … reuse your _buildTopBar from earlier or inline …
              _buildTopBar(context, wp, hp, avatarSize, wp(0.5)),
              SizedBox(height: hp(4)),
              _buildSearchField(context, wp, hp),
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
              Expanded(child: _buildEmptyState(context, hp)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
    double avatarSize,
    double border,
  ) {
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
                    color: AppColors.onBackgroundSurface2,
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
            icon: ImageIcon(AssetImage(AppAssets.notification), size: wp(6)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
  ) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Run plate number...',
        hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: wp(3.3)),
          child: ImageIcon(
            AssetImage(AppAssets.search),
            size: wp(1),
            color: AppColors.onBackgroundSurface2,
          ),
        ),
        // Icon(
        //   Icons.search,
        //   size: wp(6),
        //   color: AppColors.onBackgroundSurface2,
        // ),
        contentPadding: EdgeInsets.symmetric(vertical: hp(1.5)),
        filled: true,
        fillColor: Theme.of(ctx).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(
            color: AppColors.onBackgroundSurface2,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
        ),
      ),
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
          onPressed: () => Navigator.pushNamed(ctx, '/history'),
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

  Widget _buildEmptyState(BuildContext ctx, double Function(double) hp) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Media capture yet',
                style: Theme.of(
                  ctx,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
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
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
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
