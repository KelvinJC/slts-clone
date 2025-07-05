import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import '../widgets/profile_field.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wp = context.wp;
    final hp = context.hp;

    // TODO: replace these with values from your user state
    final userName = 'Oyewumi Olukunle';
    final userId = 'ENF-00921';
    final email = 'officer.michael@traffic.ng';
    final phone = '+234 801 234 5678';
    final address = 'Victoria Island Unit';
    final zone = 'Victoria Island Unit';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),

          SafeArea(
            top: false,
            child: Column(
              children: [
                OverlayHeader(
                  title: 'Profile',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top card: avatar, name, ID, Edit button
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(wp(2)),
                                child: Container(
                                  padding: EdgeInsets.all(wp(4)),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(wp(2)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: wp(14),
                                        height: wp(14),
                                        padding: EdgeInsets.all(wp(0.5)),
                                        decoration: const BoxDecoration(
                                          color: AppColors.surface,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.homeGradient[0],
                                          radius: (wp(14) - 2 * wp(0.5)) / 2,
                                          backgroundImage: const AssetImage(
                                            AppAssets.avatar,
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   width: wp(14),
                                      //   height: wp(14),
                                      //   padding: EdgeInsets.all(wp(0.5)),
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: AppColors.surface,
                                      //   ),
                                      //   child: CircleAvatar(
                                      //     backgroundImage: const AssetImage(
                                      //       AppAssets.avatar,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(width: wp(4)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: hp(0.5)),
                                            Text(
                                              'ID: $userId',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: AppColors
                                                        .onBackgroundSurface,
                                                    fontSize: wp(3.2),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // TextButton(
                                      //   onPressed: () {
                                      //     Navigator.pushNamed(
                                      //       context,
                                      //       '/profile/edit',
                                      //     );
                                      //   },
                                      //   child: Text(
                                      //     'Edit',
                                      //     style: TextStyle(
                                      //       color: AppColors.primary,
                                      //       fontSize: wp(3.5),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: hp(2)),

                        // Details card
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(wp(2)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(wp(2)),
                            ),
                            padding: EdgeInsets.all(wp(4)),
                            child: Column(
                              children: [
                                ProfileField(
                                  icon: AppAssets.mail,
                                  label: 'Email',
                                  value: email,
                                ),

                                ProfileField(
                                  icon: AppAssets.phone,
                                  label: 'Phone',
                                  value: phone,
                                ),

                                ProfileField(
                                  icon: AppAssets.globe,
                                  label: 'Address',
                                  value: address,
                                ),

                                ProfileField(
                                  icon: AppAssets.globe,
                                  label: 'Zone',
                                  value: zone,
                                ),
                              ],
                            ),
                          ),
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
