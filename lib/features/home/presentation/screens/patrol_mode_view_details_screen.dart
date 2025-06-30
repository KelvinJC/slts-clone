import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class PatrolModeViewDetailsScreen extends ConsumerWidget {
  /// The map of detail labels → values.
  final Map<String, String> details;

  const PatrolModeViewDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wp = context.wp;
    final hp = context.hp;
    final imagePath = AppAssets.patrolModePlaceholder;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            top: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: hp(45),
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(wp(3)),
                              ),
                              child: imagePath.startsWith('http')
                                  ? Image.network(
                                      imagePath,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      imagePath,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      // Details card
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: wp(4),
                          vertical: hp(2),
                        ),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(wp(2.5)),
                          child: Container(
                            padding: EdgeInsets.all(wp(4)),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(wp(2.5)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vehicle Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),

                                // Generate rows from the details map
                                for (final entry in details.entries)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: hp(1.5)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: wp(40),
                                          child: Text(
                                            entry.key,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: AppColors
                                                      .onBackgroundSurface,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: wp(3.5),
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            entry.value,
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: wp(3.5),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                OverlayHeader(
                  title: 'Patrol Mode',
                  onBack: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
