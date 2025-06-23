import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/create_violation_tab.dart';
import '../widgets/tabs/profile_tab.dart';
import '../widgets/nav_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // The three pages
  static const _pages = [HomeTab(), CreateViolationTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;

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

      bottomNavigationBar: _buildBottomBar(context, wp),
    );
  }

  Widget _buildGradientFAB(BuildContext ctx, double Function(double) wp) {
    return Container(
      width: wp(16),
      height: wp(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.buttonGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary30,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        padding: EdgeInsets.zero,
        onPressed: () => {
          // Navigator.pushNamed(ctx, '/createViolation')
        },
        child: Icon(Icons.add, size: wp(8), color: AppColors.surface),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext ctx, double Function(double) wp) {
    return BottomAppBar(
      color: AppColors.surface,
      elevation: 0,
      shape: const CircularNotchedRectangle(inverted: true),
      notchMargin: wp(3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wp(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              asset: AppAssets.home, // replace with your home asset
              label: 'Home',
              selected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            NavItem(
              asset: null,
              label: 'Create Violation',
              selected: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            NavItem(
              asset: AppAssets.profile, // replace with your profile asset
              label: 'Profile',
              selected: _currentIndex == 2,
              onTap: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    );
  }
}
