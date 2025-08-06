import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slts_enforcer_app/core/utils/formatter_utils.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/id_capture_notifier.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/resend_link_notifier.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/vehicle_impounded_notifier.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/error_popup_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/popup_container.dart';
import 'package:slts_enforcer_app/ui/widgets/success_popup_widget.dart';

// image scrolls with cards
class ViolationReportScreen extends ConsumerStatefulWidget {
  /// The single violation we’re inspecting.
  final Violation violation;
  final String title;
  const ViolationReportScreen({
    super.key,
    required this.violation,
    this.title = 'Violation Report',
  });

  @override
  ConsumerState<ViolationReportScreen> createState() =>
      _ViolationReportScreenState();
}

class _ViolationReportScreenState extends ConsumerState<ViolationReportScreen> {
  bool showPopUp = false;

  bool iDCollected = false,
      vehicleImpounded = false,
      resendLink = false,
      share = false;

  void toggleCard({
    bool iDCollected = false,
    bool vehicleImpounded = false,
    bool resendLink = false,
    bool share = false,
  }) {
    setState(() {
      this.iDCollected = iDCollected;
      this.vehicleImpounded = vehicleImpounded;
      this.resendLink = resendLink;
      this.share = share;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final imagePath = AppAssets.plateNumberPlaceHolder;

    // ID Collected
    final iDCollectedState = ref.watch(idCaptureProvider);
    final iDCollectedCtrl = ref.read(idCaptureProvider.notifier);

    // Vehicle Impounded
    final vehicleImpoundedState = ref.watch(vehicleImpoundedProvider);
    final vehicleImpoundedCtrl = ref.read(vehicleImpoundedProvider.notifier);

    // Resend Link Impounded
    final resendLinkState = ref.watch(resendLinkProvider);
    final resendLinkCtrl = ref.read(resendLinkProvider.notifier);

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
                            child: imagePath.startsWith('http')
                                ? Image.network(
                                    imagePath,
                                    width: double.infinity,
                                    height: hp(30),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    imagePath,
                                    width: double.infinity,
                                    height: hp(30),
                                    fit: BoxFit.cover,
                                  ),
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
                                _row(
                                  'Full Name',
                                  widget.violation.offenderName,
                                  wp,
                                ),
                                // _row(
                                //   'ID Number (Drivers Lic.)',
                                //   widget.violation.pcnNumber,
                                //   wp,
                                // ),
                                _row(
                                  'Phone Number',
                                  widget.violation.phoneNumber,
                                  wp,
                                ),
                                _row('Address', '-', wp),
                                _row('Gender', '-', wp),
                                _row('Date of Birth', '-', wp),
                                _row(
                                  'License Plate',
                                  widget.violation.plateNumber,
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
                                  widget.violation.plateNumber,
                                  wp,
                                ),
                                _row(
                                  'Vehicle Type',
                                  widget.violation.vehicleTypeName,
                                  wp,
                                ),
                                _row(
                                  'Make & Model',
                                  widget.violation.vehicleBrandName,
                                  wp,
                                ),
                                _row(
                                  'Color',
                                  widget.violation.vehicleColorName,
                                  wp,
                                ),
                                // _row('Registration Exp. Date', '-', wp),
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
                                    widget.violation.violationDate,
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
                                  widget.violation.offenceName,
                                  wp,
                                ),
                                _row(
                                  'Offence Code',
                                  widget.violation.offenceCode,
                                  wp,
                                ),
                                _row('Severity Level', '-', wp),
                                _row(
                                  'Amount',
                                  '₦${formatNumberWithCommas(widget.violation.amount, 0)}',
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
                            width: double.infinity,
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
                                // widget.violation.files.isEmpty
                                //     ? const Text('None')
                                //     : Wrap(
                                //         spacing: 8,
                                //         runSpacing: 8,
                                //         children: widget.violation.files.map((
                                //           f,
                                //         ) {
                                //           return SizedBox(
                                //             width: context.wp(26),
                                //             height: context.wp(26),
                                //             child: ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(4),
                                //               child: Image.network(
                                //                 f.filePath,
                                //                 width: double.infinity,
                                //                 height: hp(30),
                                //                 fit: BoxFit.cover,
                                //               ),
                                //             ),
                                //           );
                                //         }).toList(),
                                //       ),
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
                  title: widget.title,
                  onBack: () => Navigator.of(context).pop(),
                  showIcon: true,
                  icon: AppAssets.menu,
                  onIconTap: () => setState(() {
                    showPopUp = !showPopUp;
                  }),
                ),
                if (showPopUp)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: wp(5), top: hp(12)),
                      child: Material(
                        borderRadius: BorderRadius.circular(wp(3)),
                        elevation: 1,
                        child: Container(
                          width: wp(50),
                          padding: EdgeInsets.all(wp(2)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(wp(3)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPopUpRow('ID Collected', () {
                                toggleCard(iDCollected: true);
                              }),
                              _buildPopUpRow('Vehicle Inpounded', () {
                                toggleCard(vehicleImpounded: true);
                              }),
                              _buildPopUpRow('Resend Link', () {
                                toggleCard(resendLink: true);
                              }),
                              _buildPopUpRow('Share', () {
                                // toggleCard(share: true);
                                SharePlus.instance.share(
                                  ShareParams(
                                    text:
                                        'check out my website https://example.com',
                                  ),
                                );
                              }),
                              SizedBox(height: hp(2)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                /// ID Collected
                iDCollected
                    ? (iDCollectedState.error != null
                          ? ErrorPopupWidget(
                              onClose: () {
                                iDCollectedCtrl.resetError();
                              },
                              errorMessage: iDCollectedState.error,
                            )
                          : iDCollectedCtrl.isSubmitted
                          ? SuccessPopupWidget(
                              onClose: () {
                                iDCollectedCtrl.reset(fromSuccess: true);
                                toggleCard();
                              },
                              message:
                                  'Enforcement action has been recorded successfully.',
                            )
                          : PopupContainer(
                              onClose: () {
                                iDCollectedCtrl.reset();
                                toggleCard();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // — Title
                                  Text(
                                    'Select ID Type',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),

                                  // — Driver’s License
                                  SizedBox(
                                    height: hp(5),
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('Driver’s License'),
                                      value: iDCollectedState.hasDriversLicense,
                                      onChanged:
                                          iDCollectedCtrl.toggleDriversLicense,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          wp(1),
                                        ),
                                      ),
                                      side: BorderSide(
                                        color: AppColors.onBackgroundSurface2,
                                        width: wp(0.4),
                                      ),
                                      checkboxScaleFactor: 1.2,
                                    ),
                                  ),

                                  // — Vehicle Particulars
                                  SizedBox(
                                    height: hp(5),
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('Vehicle Particulars'),
                                      value: iDCollectedState
                                          .hasVehicleParticulars,
                                      onChanged: iDCollectedCtrl
                                          .toggleVehicleParticulars,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          wp(1),
                                        ),
                                      ),
                                      side: BorderSide(
                                        color: AppColors.onBackgroundSurface2,
                                        width: context.wp(0.4),
                                      ),
                                      checkboxScaleFactor: 1.2,
                                    ),
                                  ),

                                  SizedBox(height: context.hp(4)),

                                  // — Comment label
                                  Text(
                                    'Comment',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: context.hp(2)),

                                  // — Comment field
                                  AppTextField(
                                    hintText: 'Write here…',
                                    maxLines: 5,
                                    controller: iDCollectedCtrl.controller,
                                    validateBorder:
                                        iDCollectedState.commentTouched,
                                    isValid: iDCollectedCtrl.commentIsValid(),
                                    onChanged: iDCollectedCtrl.updateComment,
                                  ),
                                  SizedBox(height: context.hp(0.5)),

                                  // — Hint
                                  Text(
                                    'Not more than 50 words',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.onBackgroundSurface2,
                                        ),
                                  ),

                                  SizedBox(height: context.hp(3)),

                                  // — Buttons
                                  _buildActionRowForCard(
                                    wp,
                                    hp,
                                    allowProceed: iDCollectedCtrl.canSubmit(),
                                    onTapBtnOne: () {
                                      iDCollectedCtrl.reset();
                                      toggleCard();
                                    },
                                    onTapBtnTwo: () => iDCollectedCtrl.submit(),
                                    isLoading: iDCollectedState.loading,
                                  ),
                                  SizedBox(height: context.hp(2)),
                                ],
                              ),
                            ))
                    : SizedBox.shrink(),

                /// Vehicle Impounded Card
                vehicleImpounded
                    ? (vehicleImpoundedState.error != null
                          ? ErrorPopupWidget(
                              onClose: () {
                                vehicleImpoundedCtrl.resetError();
                              },
                              errorMessage: vehicleImpoundedState.error,
                            )
                          : vehicleImpoundedCtrl.isSubmitted
                          ? SuccessPopupWidget(
                              onClose: () {
                                vehicleImpoundedCtrl.reset(fromSuccess: true);
                                toggleCard();
                              },
                              message:
                                  'Enforcement action has been recorded successfully.',
                            )
                          : PopupContainer(
                              onClose: () {
                                vehicleImpoundedCtrl.reset();
                                toggleCard();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // — Comment label
                                  Text(
                                    'Comment',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: context.hp(2)),

                                  // — Comment field
                                  AppTextField(
                                    hintText: 'Write here…',
                                    maxLines: 5,
                                    controller: vehicleImpoundedCtrl.controller,
                                    validateBorder:
                                        vehicleImpoundedState.commentTouched,
                                    isValid: vehicleImpoundedCtrl
                                        .commentIsValid(),
                                    onChanged:
                                        vehicleImpoundedCtrl.updateComment,
                                  ),
                                  SizedBox(height: context.hp(0.5)),

                                  // — Hint
                                  Text(
                                    'Not more than 50 words',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.onBackgroundSurface2,
                                        ),
                                  ),

                                  SizedBox(height: context.hp(3)),

                                  // — Buttons
                                  _buildActionRowForCard(
                                    wp,
                                    hp,
                                    allowProceed: vehicleImpoundedCtrl
                                        .canSubmit(),
                                    onTapBtnOne: () {
                                      vehicleImpoundedCtrl.reset();
                                      toggleCard();
                                    },
                                    onTapBtnTwo: () =>
                                        vehicleImpoundedCtrl.submit(),
                                    isLoading: vehicleImpoundedState.loading,
                                  ),
                                  SizedBox(height: context.hp(2)),
                                ],
                              ),
                            ))
                    : SizedBox.shrink(),

                /// Resend Link Card
                resendLink
                    ? (resendLinkState.error != null
                          ? ErrorPopupWidget(
                              onClose: () {
                                resendLinkCtrl.resetError();
                              },
                              errorMessage: resendLinkState.error,
                            )
                          : resendLinkCtrl.isSubmitted
                          ? SuccessPopupWidget(
                              onClose: () {
                                resendLinkCtrl.reset(fromSuccess: true);
                                toggleCard();
                              },
                              message:
                                  'Enforcement action has been recorded successfully.',
                            )
                          : PopupContainer(
                              onClose: () {
                                resendLinkCtrl.reset();
                                toggleCard();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // — Hint
                                  Text(
                                    'Enter your email address so we could send the link to you.',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          // color: AppColors.onBackgroundSurface2,
                                        ),
                                  ),
                                  SizedBox(height: context.hp(3)),

                                  // — Email label
                                  Text(
                                    'Email',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: context.hp(2)),

                                  // — Comment field
                                  AppTextField(
                                    hintText: 'Email address…',
                                    controller: resendLinkCtrl.controller,
                                    validateBorder:
                                        resendLinkState.emailTouched,
                                    isValid: resendLinkCtrl.emailIsValid(),
                                    onChanged: resendLinkCtrl.updateEmail,
                                    verticalPadding: 2,
                                  ),

                                  SizedBox(height: context.hp(4)),

                                  // — Buttons
                                  _buildActionRowForCard(
                                    wp,
                                    hp,
                                    allowProceed: resendLinkCtrl.canSubmit(),
                                    onTapBtnOne: () {
                                      resendLinkCtrl.reset();
                                      toggleCard();
                                    },
                                    onTapBtnTwo: () => resendLinkCtrl.submit(),
                                    isLoading: resendLinkState.loading,
                                    title2: 'Send',
                                  ),
                                  SizedBox(height: context.hp(2)),
                                ],
                              ),
                            ))
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRowForCard(
    double Function(double) wp,
    double Function(double) hp, {
    String title1 = 'Cancel',
    String title2 = 'Proceed',
    bool allowProceed = false,
    void Function()? onTapBtnOne,
    void Function()? onTapBtnTwo,
    bool isLoading = false,
  }) {
    Widget childWidget(String text, bool allow, {bool loading = false}) {
      return loading
          ? SizedBox(
              width: wp(6),
              height: wp(6),
              child: const CircularProgressIndicator(
                color: AppColors.onPrimary,
                strokeWidth: 2.5,
              ),
            )
          : Text(
              text,
              // maxLines: 1,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: allow
                    ? AppColors.onPrimary
                    : AppColors.onBackgroundSurface2,
                fontSize: wp(4.5),
                fontWeight: FontWeight.bold,
              ),
            );
    }

    return Container(
      color: AppColors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GradientButton(
              height: 6.5,
              isGradient: !allowProceed,
              child: childWidget(title1, !allowProceed),
              onPressed: () =>
                  !allowProceed && onTapBtnOne != null ? onTapBtnOne() : null,
            ),
          ),
          SizedBox(width: wp(4)),
          Expanded(
            child: GradientButton(
              height: 6.5,
              isLoading: isLoading,
              isGradient: allowProceed,
              child: childWidget(title2, allowProceed, loading: isLoading),
              onPressed: () =>
                  allowProceed && onTapBtnTwo != null ? onTapBtnTwo() : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpRow(String text, void Function()? onPressed) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface),
        ),
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
