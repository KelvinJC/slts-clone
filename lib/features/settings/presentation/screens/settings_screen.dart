import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import '../widgets/setting_item.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _State();
}

class _State extends ConsumerState<SettingsScreen> {
  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    isSwitchOn = ref.read(authNotifierProvider).user?.is2faEnabled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // your blurry gradient background
          BlurryGradientBackground(colors: AppColors.homeGradient),

          SafeArea(
            top: false,
            child: Column(
              children: [
                // overlay header with back button and title
                OverlayHeader(
                  title: 'Settings',
                  onBack: () => Navigator.of(context).pop(),
                  opacity: 0,
                  topPadding: 8,
                  height: 15,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: wp(4),
                      vertical: hp(2),
                    ),
                    child: Column(
                      children: [
                        // Account Settings section
                        _SettingsSection(
                          title: 'Account Settings',
                          items: [
                            SettingItemData(
                              icon: AppAssets.profile,
                              label: 'Profile',
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                            ),
                            SettingItemData(
                              icon: AppAssets.lock,
                              label: 'Change Password',
                              onTap: () {
                                // Navigator.pushNamed(context, '/changePassword');
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: hp(2)),

                        // General section
                        _SettingsSection(
                          title: 'General',
                          items: [
                            SettingItemData(
                              icon: AppAssets.help,
                              label: 'Help & Support',
                              onTap: () {
                                // Navigator.pushNamed(context, '/help');
                              },
                            ),
                            SettingItemData(
                              icon: AppAssets.shield,
                              label: 'Privacy Policy',
                              onTap: () {
                                // Navigator.pushNamed(context, '/privacyPolicy');
                              },
                            ),
                            SettingItemData(
                              icon: AppAssets.shield,
                              label: '2FA',
                              onTap: () {
                                // Navigator.pushNamed(context, '/privacyPolicy');
                              },
                              isSwitchOn: isSwitchOn,
                              onSwitchChanged: (value) {
                                // setState(() {
                                //   isSwitchOn = !isSwitchOn;
                                // });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '2FA must be left enabled for security reasons',
                                    ),
                                  ),
                                );
                              },
                            ),
                            SettingItemData(
                              icon: AppAssets.logout,
                              label: 'Log Out',
                              onTap: () {
                                ref.read(authNotifierProvider.notifier).reset();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/login',
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple section with a title and a white rounded card of items.
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingItemData> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(wp(2)),
      child: Container(
        padding: EdgeInsets.all(wp(4)),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(wp(2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                // fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: hp(1.5)),
            ...items.map(
              (data) => Column(
                children: [
                  if (data == items.last && title.toLowerCase() == 'general')
                    SizedBox(height: hp(10)),
                  SettingItem(data: data),
                  // if (data != items.last)
                  //   Divider(
                  //     height: 1,
                  //     color: AppColors.onBackgroundSurface2,
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
