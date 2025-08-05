import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class ResendLinkNotificationScreen extends StatelessWidget {
  const ResendLinkNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hp = context.hp;
    final wp = context.wp;

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
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: wp(5), right: wp(5), top: hp(15)),
                                child: Column(
                                  children: [
                                    DetailsCard(
                                        hp: hp,
                                        wp: wp,
                                        header: 'Offender Details',
                                        detailsInfo: offenderDetails
                                    ),
                                    SizedBox(height: hp(2)),
                                    DetailsCard(
                                        hp: hp,
                                        wp: wp,
                                        header: 'Vehicle Info',
                                        detailsInfo: vehicleInfo
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        OverlayHeader(
                          title: 'Violation Report',
                          onBack: () => {Navigator.pop(context)},
                          rightIcon: AppAssets.menu,
                          onRightIconTap: () => {},
                        ),
                        Container(
                          width: wp(100),
                          height: hp(100),
                          color: AppColors.grayOverlay,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: wp(5)),
                            child: Container(
                              height: hp(40),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.onPrimary,
                                  borderRadius: BorderRadius.circular(wp(5)),
                                  border: Border.all(
                                    color: AppColors.onBackgroundSurface2,
                                    width: 0.5,
                                  )
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(
                                          size: 25.0,
                                          Icons.cancel,
                                          color: AppColors.onBackgroundSurface
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppAssets.checkMark,
                                        width: wp(20),
                                        height: hp(20),
                                      ),
                                      Column(
                                          children: [
                                            Text(
                                              'Link has been sent to',
                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: AppColors.onBackgroundSurface,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              'oye******i.ol*******@gmail.com,',
                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: AppColors.onBackgroundSurface,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              'please check your email.',
                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: AppColors.onBackgroundSurface,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ]
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]
                  )
              )
            ]
        )
    );
  }
}