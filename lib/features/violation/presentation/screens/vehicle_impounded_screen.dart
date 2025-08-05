import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blank_button_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';


class VehicleImpoundedScreen extends StatelessWidget {
  // final Violation violation;
  const VehicleImpoundedScreen({super.key});

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
                              height: hp(45),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                        size: 25.0,
                                        Icons.cancel,
                                        color: AppColors.onBackgroundSurface
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Comment',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: AppColors.onBackgroundSurface,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: wp(2)),
                                          TextFormField(
                                            maxLines: 4,
                                            onChanged: (String val) {
                                              // if (val.trim() != '') {
                                              //   ref
                                              //       .read(loginFormProvider.notifier)
                                              //       .setFieldToFilled('password', emailValue: '');
                                              // } else {
                                              //   ref
                                              //       .read(loginFormProvider.notifier)
                                              //       .setFieldToUnfilled('password');
                                              // }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Write here...',
                                              hintStyle: TextStyle(
                                                color: AppColors.onBackgroundSurface2,
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).colorScheme.surface,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(wp(2)),
                                                borderSide: BorderSide(
                                                  color: AppColors.onBackgroundSurface2,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(wp(2)),
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Not more than 50 words',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: AppColors.onBackgroundSurface2,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(height: hp(5)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () => Navigator.pop(context),
                                                child: SizedBox(
                                                  width: wp(35),
                                                  child: BlankButton(text: 'Cancel'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: wp(35),
                                                child: GradientButton(
                                                  onPressed: () => Navigator.popAndPushNamed(context, '/enforcementNotification'),
                                                  child: Text(
                                                    'Proceed',
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                      color: AppColors.onPrimary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]
                                    ),
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