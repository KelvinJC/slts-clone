import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/utils/ocr_utils.dart';
import 'package:slts_enforcer_app/features/search/presentation/screens/search_screen.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/create_violation_tab.dart';
import '../widgets/tabs/settings_tab.dart';
import '../widgets/nav_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // The three pages
  static const _pages = [HomeTab(), CreateViolationTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Scaffold(
      // extendBody: true,
      backgroundColor: AppColors.surface,

      // swap out the body
      body: IndexedStack(index: _currentIndex, children: _pages),

      // only show FAB on the dashboard tab
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _currentIndex == 0
          // || _currentIndex == 2
          ? _buildGradientFAB(context, wp)
          : null,

      bottomNavigationBar: _buildBottomBar(context, wp, hp),
    );
  }

  Widget _buildGradientFAB(BuildContext ctx, double Function(double) wp) {
    return FloatingActionButton(
      onPressed: () {
        detectPlateAndNavigate(
          context,
          onSelected: (plate) {
            // navigate to SearchScreen, passing initial value
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreen(initialQuery: plate),
              ),
            );
          },
        );
      },
      backgroundColor: AppColors.surface,
      splashColor: AppColors.buttonGradient[1].withAlpha(50),
      elevation: 0,
      shape: const CircleBorder(),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: AppColors.buttonGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        blendMode: BlendMode.srcIn,
        child: ImageIcon(
          AssetImage(AppAssets.camera),
          size: wp(8),
          color: AppColors.surface,
        ),
      ),
    );
    // Container(
    //   width: wp(15),
    //   height: wp(15),
    //   decoration: BoxDecoration(
    //     // gradient: LinearGradient(
    //     //   colors: AppColors.buttonGradient,
    //     //   begin: Alignment.centerLeft,
    //     //   end: Alignment.centerRight,
    //     // ),
    //     color: AppColors.surface,
    //     shape: BoxShape.circle,
    //     boxShadow: [
    //       BoxShadow(
    //         color: AppColors.primary30,
    //         blurRadius: 8,
    //         offset: Offset(0, 4),
    //       ),
    //     ],
    //   ),
    //   child: RawMaterialButton(
    //     // shape: const CircleBorder(),
    //     padding: EdgeInsets.zero,
    //     onPressed: () => {
    //       // Navigator.pushNamed(ctx, '/createViolation')
    //     },
    //     child: ShaderMask(
    //       shaderCallback: (bounds) => const LinearGradient(
    //         colors: AppColors.buttonGradient,
    //         begin: Alignment.centerLeft,
    //         end: Alignment.centerRight,
    //       ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
    //       blendMode: BlendMode.srcIn,
    //       child: ImageIcon(
    //         AssetImage(AppAssets.camera),
    //         size: wp(8),
    //         color: AppColors.surface,
    //       ),
    //     ),
    //     // Icon(Icons.add, size: wp(8), color: AppColors.surface),
    //   ),
    // );
  }

  Widget _buildBottomBar(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
  ) {
    return BottomAppBar(
      height: hp(7),
      color: AppColors.surface,
      elevation: 0,
      shape: const CircularNotchedRectangle(inverted: true),
      // notchMargin: wp(2),
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wp(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              asset: AppAssets.home,
              label: 'Home',
              selected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            NavItem(
              asset: null,
              label: 'Quick Capture',
              selected: _currentIndex == 1,
              onTap: () {
                // setState(() => _currentIndex = 1);
                detectPlateAndNavigate(
                  context,
                  onSelected: (plate) {
                    // navigate to SearchScreen, passing initial value
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen(initialQuery: plate),
                      ),
                    );
                  },
                );
              },
            ),
            NavItem(
              asset: AppAssets.settings,
              label: 'Settings',
              selected: _currentIndex == 2,
              onTap: () {
                // setState(() => _currentIndex = 2);
                Navigator.pushNamed(ctx, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
