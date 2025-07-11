import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/utils/formatter_utils.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class SearchResultScreen extends ConsumerWidget {
  /// The single violation we’re inspecting.
  final Violation violation;

  const SearchResultScreen({Key? key, required this.violation})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wp = context.wp;
    final hp = context.hp;

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
                      // HEAD IMAGE (plate photo placeholder)
                      SizedBox(
                        height: hp(35),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(wp(3)),
                          ),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppAssets.platePlaceholder),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // //imagePath from Violation here...
                            // child: Image.asset(
                            //   AppAssets.platePlaceholder,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(height: hp(2)),

                      // DETAILS CARD (Offender Details)
                      Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Material(
                          elevation: 1,
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
                                  'Offender Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),
                                _row('Full Name', violation.offenderName, wp),
                                _row(
                                  'ID Number (Drivers Lic.)',
                                  violation.pcnNumber,
                                  wp,
                                ),
                                _row('Phone Number', violation.phoneNumber, wp),
                                _row('Address', '-', wp),
                                _row('Gender', '-', wp),
                                _row('Date of Birth', '-', wp),
                                _row(
                                  'License Plate',
                                  violation.plateNumber,
                                  wp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // DETAILS CARD (Viehicle Info)
                      Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Material(
                          elevation: 1,
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
                                  'Viehicle Info',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),

                                _row(
                                  'License Plate Number',
                                  violation.plateNumber,
                                  wp,
                                ),
                                _row(
                                  'Vehicle Type',
                                  violation.vehicleTypeName,
                                  wp,
                                ),
                                _row(
                                  'Make & Model',
                                  violation.vehicleBrandName,
                                  wp,
                                ),
                                _row('Color', violation.vehicleColorName, wp),
                                _row('Registration Exp. Date', '-', wp),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // DETAILS CARD (Location of Offence)
                      Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Material(
                          elevation: 1,
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
                                  'Location of Offence',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),
                                _row('Street Name', '-', wp),
                                _row('State', '-', wp),
                                _row('City', '-', wp),
                                _row('Color', '-', wp),
                                _row(
                                  'Date & Time',
                                  formatDateShort(
                                    violation.violationDate,
                                    pattern: 'dd-MM-yyyy',
                                  ),
                                  wp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // DETAILS CARD (Offence Type, Amount and Description)
                      Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Material(
                          elevation: 1,
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
                                  'Offence Type, Amount and Description',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),
                                _row(
                                  'Offence Type',
                                  violation.eventTypeName,
                                  wp,
                                ),
                                _row('Offence Code', violation.offenceCode, wp),
                                _row('Severity Level', '-', wp),
                                _row(
                                  'Amount',
                                  '₦${formatNumberWithCommas(violation.amount, 0)}',
                                  wp,
                                ),
                                _row('Notes', '-', wp),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // DETAILS CARD (Media Capture)
                      Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Material(
                          elevation: 1,
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
                                  'Media Capture',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: hp(2)),
                                _row('Notes', '-', wp),
                                SizedBox(height: hp(10)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                OverlayHeader(
                  title: 'Recent Capture',
                  onBack: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, double Function(double) wp) {
    return Padding(
      padding: EdgeInsets.only(bottom: wp(2)),
      child: Row(
        children: [
          SizedBox(
            width: wp(40),
            child: Text(
              '$label:',
              style: TextStyle(
                color: AppColors.onBackgroundSurface,
                fontWeight: FontWeight.bold,
                fontSize: wp(3.5),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.onBackground,
                fontSize: wp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
