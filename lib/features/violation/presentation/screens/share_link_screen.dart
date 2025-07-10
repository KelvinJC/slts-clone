import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

final List<String> icons = [
  AppAssets.twitter,
  AppAssets.linkedIn,
  AppAssets.whatsApp,
  AppAssets.instaGram,
  AppAssets.copyLink,
  // Add more as needed
];

class ShareLinkScreen extends StatelessWidget {
  // final Violation violation;
  const ShareLinkScreen({super.key});

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

                        Padding(
                          padding: EdgeInsets.only(top: hp(60)),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: wp(4), horizontal: wp(5)),

                            decoration: BoxDecoration(
                                color: AppColors.onPrimary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(wp(5)),
                                ),
                                border: Border.all(
                                  color: AppColors.onBackgroundSurface2,
                                  width: 0.5,
                                )
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Share',
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: AppColors.onBackgroundSurface,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                            size: 25.0,
                                            Icons.cancel,
                                            color: AppColors.onBackgroundSurface
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[200],
                                    thickness: 2,
                                  ),
                                  SizedBox(height: hp(2)),
                                  Wrap(
                                    spacing: wp(13.5),
                                    runSpacing: hp(6),
                                    children: icons.map((assetPath) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Replace with your actual action
                                          print('Tapped on $assetPath');
                                        },
                                        child: Image.asset(
                                          assetPath,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ]
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


