import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_app_bar.dart';

class PatrolModeScreen extends ConsumerWidget {
  const PatrolModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wp = context.wp;
    final hp = context.hp;
    final imagePath = AppAssets.patrolModePlaceholder;
    final rows = [
      [
        const Text('ABC-12Z246'),
        const Text('Not Paid', style: TextStyle(color: AppColors.danger)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
      [
        const Text('ABC-12Z246'),
        const Text('Paid', style: TextStyle(color: AppColors.success)),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility, color: AppColors.onBackgroundSurface),
        ),
      ],
    ];
    final headers = [
      const Text('Plate Number'),
      const Text('Status'),
      const Text('View'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: hp(42),
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
                        child: HtmlTable(
                          headers: headers,
                          rows: rows,
                          columnWidths: [
                            FixedColumnWidth(wp(40)),
                            FixedColumnWidth(wp(30)),
                            FixedColumnWidth(wp(20)),
                          ],
                          borderRadius: BorderRadius.circular(12),
                          outerBorderColor: AppColors.onBackgroundSurface2,
                          innerBorderColor: AppColors.onBackgroundSurface2,
                          // cellWidth: 100,
                          rowHeight: hp(2.5),
                          cellPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                OverlayAppBar(
                  title: 'Patrol Mode',
                  onBack: () => Navigator.of(context).pop(),
                  opacity: 0.5,
                  // backgroundColor defaults to white
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
