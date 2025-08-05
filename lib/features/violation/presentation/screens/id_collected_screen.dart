import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blank_button_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class IdCollectedScreen extends StatelessWidget {
  // final Violation violation;
  const IdCollectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hp = context.hp;
    final wp = context.wp;

    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode focusScopeNode = FocusScope.of(context);
            if(!focusScopeNode.hasPrimaryFocus) {
              focusScopeNode.unfocus();
            }
          },
          child: Stack(
              children: [
                BlurryGradientBackground(colors: AppColors.homeGradient),
                SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      child: Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: wp(5),
                                      right: wp(5),
                                      top: hp(15)
                                  ),
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
                            OverlayHeader(
                              title: 'Violation Report',
                              onBack: () => {Navigator.pop(context)},
                              rightIcon: AppAssets.menu,
                              onRightIconTap: () => {},
                            ),
                            Positioned.fill(
                              child: Container(
                                color: AppColors.grayOverlay,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(28)),
                                child: Container(
                                  height: hp(65),
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
                                                'Select ID Type',
                                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: AppColors.onBackgroundSurface,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                visualDensity: VisualDensity(vertical: -4), // Reduce vertical spacing
                                                title: Text(
                                                  'Driver\'s License',
                                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                    color: AppColors.onBackgroundSurface,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                value: false,
                                                onChanged: (bool? newValue) {},
                                                controlAffinity:
                                                ListTileControlAffinity.leading,
                                                checkboxShape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(wp(1)),
                                                ),
                                                side: BorderSide(
                                                  color: AppColors.onBackgroundSurface2,
                                                  width: context.wp(0.2),
                                                ),
                                                checkboxScaleFactor: 1.0,
                                              ),
                                              CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                visualDensity: VisualDensity(vertical: -4), // Reduce vertical spacing
                                                title: Text(
                                                  'Vehicle Particulars',
                                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                    color: AppColors.onBackgroundSurface,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                value: true,
                                                onChanged: (bool? newValue) {},
                                                controlAffinity:
                                                ListTileControlAffinity.leading,
                                                checkboxShape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(wp(1)),
                                                ),
                                                side: BorderSide(
                                                  color: AppColors.onBackgroundSurface2,
                                                  width: context.wp(0.4),
                                                ),
                                                checkboxScaleFactor: 1.0,
                                              ),
                                              SizedBox(height: hp(2)),
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
                                                onChanged: (String val) {},
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
                                                  )
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
                      ),
                    )
                )
              ]
          ),
        )
    );
  }
}