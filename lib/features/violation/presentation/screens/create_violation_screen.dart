import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/utils/formatter_utils.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/violation_form_state.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/app_dropdown_field.dart';
import 'package:slts_enforcer_app/ui/widgets/error_popup_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/loading_popup_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/success_popup_widget.dart';
import '../providers/violation_notifier.dart';

enum ViolationStep { vehicleOffender, violationDetails, media, review }

class CreateViolationScreen extends ConsumerStatefulWidget {
  final Violation? violation;
  const CreateViolationScreen({super.key, this.violation});

  @override
  ConsumerState<CreateViolationScreen> createState() => _State();
}

class _State extends ConsumerState<CreateViolationScreen> {
  ViolationStep _step = ViolationStep.vehicleOffender;
  var validateOffenderOffenceBorder = false,
      validateOffenderEventTypeBorder = false,
      validateOffenderViolationDateBorder = false,
      validateOffenderZoneBorder = false,
      validateOffenderCommandBorder = false,
          // validateOffenderFirstNameBorder = false,
          // validateOffenderSurnameBorder = false,
          // validateOffenderPhoneBorder = false,
          // validateOffenderEmailBorder = false,
          validateVehiclePlateBorder =
          false;
  // validateVehicleTypeBorder = false,
  // validateVehiclePlateColorBorder = false,
  // validateVehicleBrandBorder = false,
  // validateVehicleVehicleTypeBorder = false,
  // validateVehicleColorBorder = false;
  String? isSubmittedMsg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(violationNotifierProvider.notifier)
          .loadSettings(v: widget.violation),
    );
  }

  bool isViolationDetailsValid() {
    final form = ref.read(violationNotifierProvider);
    return form.offence != null &&
        form.eventType != null &&
        form.date.isNotEmpty &&
        form.zone != null &&
        form.command != null;
  }

  Future<bool> isVehicleOffenderDetailsValid() async {
    final form = ref.read(violationNotifierProvider);
    final notifier = ref.read(violationNotifierProvider.notifier);
    if (notifier.plateNoController.text.isEmpty) return false;
    if (notifier.plateNoController.text.trim() == form.plate.trim()) {
      return true;
    }

    FocusScope.of(context).unfocus();
    await notifier.search(isNext: true);
    if (notifier.list.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No results found for "${notifier.plateNoController.text}"',
          ),
        ),
      );
    }
    return notifier.list.isNotEmpty;
  }

  void _next() async {
    if (_step == ViolationStep.vehicleOffender) {
      final isVehicleOffenderValid = await isVehicleOffenderDetailsValid();
      if (!isVehicleOffenderValid) {
        setState(() {
          validateVehiclePlateBorder = true;
        });
        return;
      }
    }

    if (_step == ViolationStep.violationDetails) {
      if (!isViolationDetailsValid()) {
        setState(() {
          validateOffenderOffenceBorder = true;
          validateOffenderEventTypeBorder = true;
          validateOffenderViolationDateBorder = true;
          validateOffenderZoneBorder = true;
          validateOffenderCommandBorder = true;
        });
        return;
      }
    }

    if (_step == ViolationStep.media) {
      if (ref.read(violationNotifierProvider).mediaPaths.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please capture media')));
        return; // Prevent moving to next step if no media is captured
      }
    }

    setState(() {
      _step = ViolationStep
          .values[(_step.index + 1).clamp(0, ViolationStep.values.length - 1)];
    });
  }

  void _back({ViolationStep? step}) => setState(() {
    _step =
        step ??
        ViolationStep.values[(_step.index - 1).clamp(
          0,
          ViolationStep.values.length - 1,
        )];
  });
  String safeSubstring(String fileName) {
    int start = fileName.length > 15 ? fileName.length - 15 : 0;
    return fileName.substring(start);
  }

  Future<void> _save() async {
    final form = ref.read(violationNotifierProvider);
    if (!await isVehicleOffenderDetailsValid() ||
        !isViolationDetailsValid() ||
        form.mediaPaths.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all steps')),
      );
      return;
    }

    final notifier = ref.read(violationNotifierProvider.notifier);
    final submitted = await notifier.submit();

    String message = submitted == true
        ? 'Violation submitted successfully'
        : submitted == null
        ? 'Failed to submit'
        : 'Violation saved offline';
    if (submitted != null) {
      setState(() {
        isSubmittedMsg = message;
        //
        validateOffenderOffenceBorder = false;
        validateOffenderEventTypeBorder = false;
        validateOffenderViolationDateBorder = false;
        validateOffenderZoneBorder = false;
        validateOffenderCommandBorder = false;
        validateVehiclePlateBorder = false;
      });
      _back(step: ViolationStep.vehicleOffender);
      notifier.refreshRecentCaptures();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp, hp = context.hp;

    final formValue = ref.watch(violationNotifierProvider);
    final notifier = ref.read(violationNotifierProvider.notifier);

    final pages = [
      _offenderVehicleStep(ref, formValue, notifier),
      _violationDetailsStep(ref, formValue, notifier),
      _mediaStep(ref, formValue, notifier),
      _reviewStep(formValue, notifier),
    ];
    //
    if (formValue.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          Column(
            children: [
              OverlayHeader(
                title: 'Create Violation',
                onBack: _step == ViolationStep.vehicleOffender
                    ? () => Navigator.of(context).pop()
                    : _back,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(4)),
                  child: IndexedStack(index: _step.index, children: pages),
                ),
              ),
              // Bottom row
              Container(
                color: AppColors.surface,
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(4)),
                  child: Padding(
                    padding: EdgeInsets.only(top: hp(2.5), bottom: hp(0.5)),
                    child:
                        // — Buttons
                        _buildActionRowForCard(
                          wp,
                          hp,
                          isGradient1: false,
                          isGradient2: true,
                          title1: 'Back',
                          title2: _step == ViolationStep.review
                              ? 'Save'
                              : 'Next',
                          onTapBtnOne: _step == ViolationStep.vehicleOffender
                              ? null
                              : _back,
                          onTapBtnTwo:
                              formValue.loading || formValue.isSubmitting
                              ? null
                              : (_step == ViolationStep.review ? _save : _next),
                          isLoading:
                              formValue.loading || formValue.isSubmitting,
                        ),
                  ),
                ),
              ),
            ],
          ),

          if (isSubmittedMsg != null)
            SuccessPopupWidget(
              onClose: () {
                setState(() {
                  isSubmittedMsg = null;
                });
              },
              message: isSubmittedMsg ?? '',
            ),

          if (formValue.isSubmitting) LoadingPopupWidget(),

          if (formValue.error != null)
            ErrorPopupWidget(
              errorMessage: formValue.error?.displayMessage,
              onClose: () => notifier.resetErrors(),
            ),
        ],
      ),
    );
    //
  }

  Widget _buildActionRowForCard(
    double Function(double) wp,
    double Function(double) hp, {
    String title1 = 'Cancel',
    String title2 = 'Proceed',
    bool isGradient1 = false,
    bool isGradient2 = false,
    // bool allowProceed = false,
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
              isGradient: isGradient1,
              child: childWidget(title1, isGradient1),
              onPressed: () => onTapBtnOne != null ? onTapBtnOne() : null,
            ),
          ),
          SizedBox(width: wp(4)),
          Expanded(
            child: GradientButton(
              height: 6.5,
              isLoading: isLoading,
              isGradient: isGradient2,
              child: childWidget(title2, isGradient2, loading: isLoading),
              onPressed: () => onTapBtnTwo != null ? onTapBtnTwo() : null,
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<DropdownOption>> dropdownItemBuilder(
    List<DropdownOption> options,
  ) {
    return options
        .map(
          (o) => DropdownMenuItem(
            value: o,
            child: SizedBox(width: context.wp(80), child: Text(o.name)),
          ),
        )
        .toList();
  }

  List<Widget> selectedBuilder(List<DropdownOption> options) {
    return options.map((o) {
      return SizedBox(
        width: context.wp(75),
        child: Text(o.name, overflow: TextOverflow.ellipsis),
      );
    }).toList();
  }

  Widget _offenderVehicleStep(
    WidgetRef ref,
    ViolationFormState form,
    ViolationNotifier notifier, {
    bool isPreviewMode = false,
  }) {
    Widget _row(String label, String value, double Function(double) wp) => Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: context.wp(3)),
        Visibility(
          visible: isPreviewMode,
          child: Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: AppColors.onBackground),
            ),
          ),
        ),
      ],
    );

    //array of widgets
    var childrenArray = <Widget>[
      // header
      Padding(
        padding: EdgeInsets.only(top: context.hp(1), bottom: context.hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vehicle Info',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: isPreviewMode,
              child: GestureDetector(
                onTap: () => _back(step: ViolationStep.vehicleOffender),
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    // fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: Text(
          'Details about the vehicle involved',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),

      // — Plate Number (text)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row(
          'Enter Plate Number *',
          notifier.plateNoController.text,
          context.wp,
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppTextField(
          isPreviewMode: isPreviewMode,
          hintText: notifier.plateNoController.text ?? 'KSF-622AE',
          // initialValue: notifier.plateNoController.text,
          focusNode: notifier.plateNoFocusNode,
          controller: notifier.plateNoController,
          isProcessing: form.plateNoLoading,
          validateBorder: validateVehiclePlateBorder,
          // onChanged: (v) {
          //   if (!validateVehiclePlateBorder) validateVehiclePlateBorder = true;
          //   notifier.updateField('plate', v);
          // },
          onSubmitted: (val) {
            FocusScope.of(context).unfocus();
            // schedule the search after build is over:
            Future.microtask(() {
              if (val.trim().isNotEmpty) {
                notifier.search().then((v) {
                  if (v == null || v.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No results found for "$val"')),
                    );
                  } else {
                    notifier.refreshPatrolMode();
                  }
                });
              }
            });
          },
        ),
      ),
      if (validateVehiclePlateBorder &&
          (notifier.plateNoController.text.isEmpty || notifier.list.isEmpty))
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            notifier.plateNoController.text.isEmpty
                ? 'Please enter a plate number'
                : 'Please enter a valid plate number',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // — Plate Type (dropdown)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Plate Type *', form.plateType?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.plateType,
          items: dropdownItemBuilder(form.plateTypeOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.plateTypeOptions),
          hintText: form.plateType?.name ?? 'Choose plate type',
          // validateBorder: validateVehicleTypeBorder,
          onChanged: (v) {
            // if (!validateVehicleTypeBorder) validateVehicleTypeBorder = true;
            // notifier.updateField('plateType', v!);
          },
          enabled: false,
        ),
      ),
      // if (validateVehicleTypeBorder && form.plateType == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a plate type',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Plate Color (dropdown)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Plate Color *', form.plateColor?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.plateColor,
          items: dropdownItemBuilder(form.plateColorOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.plateColorOptions),
          hintText: form.plateColor?.name ?? 'Choose plate color',
          // validateBorder: validateVehiclePlateColorBorder,
          onChanged: (v) {
            // if (!validateVehiclePlateColorBorder) {
            //   validateVehiclePlateColorBorder = true;
            // }
            // notifier.updateField('plateColor', v!);
          },
          enabled: false,
        ),
      ),
      // if (validateVehiclePlateColorBorder && form.plateColor == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a plate color',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Vehicle Brand (dropdown)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Vehicle Brand *', form.brand?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.brand,
          items: dropdownItemBuilder(form.vehicleBrandOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.vehicleBrandOptions),
          hintText: form.brand?.name ?? 'Choose brand',
          // validateBorder: validateVehicleBrandBorder,
          onChanged: (v) {
            // if (!validateVehicleBrandBorder) validateVehicleBrandBorder = true;
            // notifier.updateField('brand', v!);
          },
          enabled: false,
        ),
      ),
      // if (validateVehicleBrandBorder && form.brand == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a vehicle brand',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Vehicle Type (dropdown)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Vehicle Type *', form.vehicleType?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.vehicleType,
          items: dropdownItemBuilder(form.vehicleTypeOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.vehicleTypeOptions),
          hintText: form.vehicleType?.name ?? 'Choose vehicle type',
          // validateBorder: validateVehicleVehicleTypeBorder,
          onChanged: (v) {
            // if (!validateVehicleVehicleTypeBorder) {
            //   validateVehicleVehicleTypeBorder = true;
            // }
            // notifier.updateField('vehicleType', v!);
          },
          enabled: false,
        ),
      ),
      // if (validateVehicleVehicleTypeBorder && form.vehicleType == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a vehicle type',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Vehicle Color (dropdown)
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row(
          'Vehicle Color *',
          form.vehicleColor?.name ?? '',
          context.wp,
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.vehicleColor,
          items: dropdownItemBuilder(form.vehicleColorOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.vehicleColorOptions),
          hintText: form.vehicleColor?.name ?? 'Choose vehicle color',
          // validateBorder: validateVehicleColorBorder,
          onChanged: (v) {
            // if (!validateVehicleColorBorder) validateVehicleColorBorder = true;
            // notifier.updateField('vehicleColor', v!);
          },
          enabled: false,
        ),
      ),
      // if (validateVehicleColorBorder && form.vehicleColor == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a vehicle color',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),
      // header
      Padding(
        padding: EdgeInsets.only(top: context.hp(3), bottom: context.hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Offender Details',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            // Visibility(
            //   visible: isPreviewMode,
            //   child: GestureDetector(
            //     onTap: () => _back(step: ViolationStep.offender),
            //     child: Text(
            //       'Edit',
            //       style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //         // fontWeight: FontWeight.bold,
            //         color: AppColors.primary,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: Text(
          'Information captured about the person committing the offense.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),

      // // — Offence dropdown
      // Padding(
      //   padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
      //   child: _row('Select Offence *', form.offence?.name ?? '', context.wp),
      // ),
      // // AppRadioDropdown<String>(
      // //   value: form.offence.isEmpty ? null : form.offence,
      // //   options: offenceOptions,
      // //   itemLabel: (o) => o,
      // //   hintText: 'Overspeeding',
      // //   showError: validateOffenderOffenceBorder,
      // //   onChanged: (v) {
      // //     if (!validateOffenderOffenceBorder) {
      // //       validateOffenderOffenceBorder = true;
      // //     }
      // //     notifier.updateField('offence', v!);
      // //   },
      // // ),
      // // SizedBox(height: context.hp(1)),
      // Visibility(
      //   visible: !isPreviewMode,
      //   child: AppDropdownField<DropdownOption>(
      //     isPreviewMode: isPreviewMode,
      //     value: form.offence,
      //     items: dropdownItemBuilder(form.offenceOptions),
      //     selectedItemBuilder: (_) => selectedBuilder(form.offenceOptions),
      //     hintText: 'Choose an offence',
      //     validateBorder: validateOffenderOffenceBorder,
      //     onChanged: (v) {
      //       if (!validateOffenderOffenceBorder) {
      //         validateOffenderOffenceBorder = true;
      //       }
      //       notifier.updateField('offence', v!);
      //     },
      //   ),
      // ),
      // if (validateOffenderOffenceBorder && form.offence == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select an offence',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // // — Event type dropdown
      // Padding(
      //   padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
      //   child: _row(
      //     'Select Event Type *',
      //     form.eventType?.name ?? '',
      //     context.wp,
      //   ),
      // ),
      // Visibility(
      //   visible: !isPreviewMode,
      //   child: AppDropdownField<DropdownOption>(
      //     isPreviewMode: isPreviewMode,
      //     value: form.eventType,
      //     items: dropdownItemBuilder(form.eventTypeOptions),
      //     selectedItemBuilder: (_) => selectedBuilder(form.eventTypeOptions),
      //     hintText: 'Choose event type',
      //     validateBorder: validateOffenderEventTypeBorder,
      //     onChanged: (v) {
      //       if (!validateOffenderEventTypeBorder) {
      //         validateOffenderEventTypeBorder = true;
      //       }
      //       notifier.updateField('eventType', v!);
      //     },
      //   ),
      // ),
      // if (validateOffenderEventTypeBorder && form.eventType == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select an event type',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // // — Violation date picker
      // Padding(
      //   padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
      //   child: _row(
      //     'Violation Date *',
      //     form.date.isNotEmpty
      //         ? formatDateShort(
      //             DateTime.parse(form.date),
      //             pattern: 'dd-MM-yyyy',
      //           )
      //         : form.date,
      //     context.wp,
      //   ),
      // ),
      // Visibility(
      //   visible: !isPreviewMode,
      //   child: GestureDetector(
      //     onTap: () async {
      //       if (isPreviewMode) return; // Disable in preview mode
      //       final picked = await showDatePicker(
      //         context: context,
      //         initialDate: form.date.isNotEmpty
      //             ? DateTime.parse(form.date)
      //             : DateTime.now(),
      //         firstDate: DateTime(2000),
      //         lastDate: DateTime.now(),
      //       );
      //       if (picked != null) {
      //         if (!validateOffenderViolationDateBorder) {
      //           validateOffenderViolationDateBorder = true;
      //         }
      //         notifier.updateField('date', picked.toIso8601String());
      //       }
      //     },
      //     child: AbsorbPointer(
      //       child: AppTextField(
      //         isPreviewMode: isPreviewMode,
      //         hintText: form.date.isEmpty
      //             ? 'Select date'
      //             : form.date.split('T').first,
      //         initialValue: form.date.isEmpty ? '' : form.date.split('T').first,
      //         validateBorder: validateOffenderViolationDateBorder,
      //         readOnly: true,
      //         keyboardType: TextInputType.datetime,
      //         suffix: Icon(
      //           Icons.calendar_today,
      //           color: AppColors.onBackgroundSurface2,
      //           size: context.wp(4),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // if (validateOffenderViolationDateBorder && form.date.isEmpty)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please choose a date',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // // — Zone dropdown
      // Padding(
      //   padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
      //   child: _row('Select Zone *', form.zone?.name ?? '', context.wp),
      // ),
      // Visibility(
      //   visible: !isPreviewMode,
      //   child: AppDropdownField<DropdownOption>(
      //     isPreviewMode: isPreviewMode,
      //     value: form.zone,
      //     items: dropdownItemBuilder(form.zoneOptions),
      //     selectedItemBuilder: (_) => selectedBuilder(form.zoneOptions),
      //     hintText: 'Choose zone',
      //     validateBorder: validateOffenderZoneBorder,
      //     onChanged: (v) async {
      //       if (!validateOffenderZoneBorder) {
      //         validateOffenderZoneBorder = true;
      //       }
      //       // await notifier.updateField('command', null);
      //       await notifier.updateField('zone', v!);
      //     },
      //   ),
      // ),
      // if (validateOffenderZoneBorder && form.zone == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a zone',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // // — Command dropdown
      // Padding(
      //   padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
      //   child: _row('Select Command *', form.command?.name ?? '', context.wp),
      // ),
      // Visibility(
      //   visible: !isPreviewMode,
      //   child: AppDropdownField<DropdownOption>(
      //     isProcessing: form.isCommandLoading,
      //     isPreviewMode: isPreviewMode,
      //     value: form.command,
      //     items: dropdownItemBuilder(form.commandOptions),
      //     selectedItemBuilder: (_) => selectedBuilder(form.commandOptions),
      //     hintText: 'Choose command',
      //     validateBorder: validateOffenderCommandBorder,
      //     onChanged: (v) {
      //       if (!validateOffenderCommandBorder) {
      //         validateOffenderCommandBorder = true;
      //       }
      //       notifier.updateField('command', v!);
      //     },
      //   ),
      // ),
      // if (validateOffenderCommandBorder && form.command == null)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please select a command',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — First name
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Offender First Name *', form.firstName, context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppTextField(
          isPreviewMode: isPreviewMode,
          hintText: form.firstName ?? 'Olukunle',
          initialValue: form.firstName,
          // validateBorder: validateOffenderFirstNameBorder,
          onChanged: (v) {
            // if (!validateOffenderFirstNameBorder) {
            //   validateOffenderFirstNameBorder = true;
            // }
            // notifier.updateField('firstName', v);
          },
          enabled: false,
        ),
      ),
      // if (validateOffenderFirstNameBorder && form.firstName.isEmpty)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please enter first name',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Surname
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Offender Surname *', form.surname, context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppTextField(
          isPreviewMode: isPreviewMode,
          hintText: form.surname ?? 'Oyewumi',
          initialValue: form.surname,
          // validateBorder: validateOffenderSurnameBorder,
          onChanged: (v) {
            // if (!validateOffenderSurnameBorder) {
            //   validateOffenderSurnameBorder = true;
            // }
            // notifier.updateField('surname', v);
          },
          enabled: false,
        ),
      ),
      // if (validateOffenderSurnameBorder && form.surname.isEmpty)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please enter surname',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Phone
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Offender Phone *', form.phone, context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppTextField(
          isPreviewMode: isPreviewMode,
          hintText: form.phone ?? '+234 81...',
          initialValue: form.phone,
          keyboardType: TextInputType.phone,
          // validateBorder: validateOffenderPhoneBorder,
          onChanged: (v) {
            // if (!validateOffenderPhoneBorder) {
            //   validateOffenderPhoneBorder = true;
            // }
            // notifier.updateField('phone', v);
          },
          enabled: false,
        ),
      ),
      // if (validateOffenderPhoneBorder && form.phone.isEmpty)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please enter phone number',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // — Phone
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: _row('Offender Email Address *', form.email, context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppTextField(
          isPreviewMode: isPreviewMode,
          hintText: form.email ?? 'jane.doe@me.com',
          initialValue: form.email,
          keyboardType: TextInputType.emailAddress,
          // validateBorder: validateOffenderEmailBorder,
          onChanged: (v) {
            // if (!validateOffenderEmailBorder) {
            //   validateOffenderEmailBorder = true;
            // }
            // notifier.updateField('email', v);
          },
          enabled: false,
        ),
      ),
      // if (validateOffenderEmailBorder && form.email.isEmpty)
      //   Padding(
      //     padding: EdgeInsets.only(top: context.hp(0.5)),
      //     child: Text(
      //       'Please enter an email address',
      //       style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
      //     ),
      //   ),

      // END
    ];
    return !isPreviewMode
        ? ListView(
            padding: EdgeInsets.only(bottom: context.hp(2)),
            children: childrenArray,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childrenArray,
          );
  }

  Widget _violationDetailsStep(
    WidgetRef ref,
    ViolationFormState form,
    ViolationNotifier notifier, {
    bool isPreviewMode = false,
  }) {
    Widget row(String label, String value, double Function(double) wp) => Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: context.wp(3)),
        Visibility(
          visible: isPreviewMode,
          child: Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: AppColors.onBackground),
            ),
          ),
        ),
      ],
    );

    //array of widgets
    var childrenArray = <Widget>[
      // header
      Padding(
        padding: EdgeInsets.only(top: context.hp(3), bottom: context.hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Offender Details',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: isPreviewMode,
              child: GestureDetector(
                onTap: () => _back(step: ViolationStep.violationDetails),
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    // fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: Text(
          'Information captured about the person committing the offense.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),

      // — Offence dropdown
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: row('Offence *', form.offence?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.offence,
          items: dropdownItemBuilder(form.offenceOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.offenceOptions),
          hintText: 'Choose offence',
          validateBorder: validateOffenderOffenceBorder,
          onChanged: (v) {
            if (!validateOffenderOffenceBorder) {
              validateOffenderOffenceBorder = true;
            }
            notifier.updateField('offence', v!);
          },
        ),
      ),
      if (validateOffenderOffenceBorder && form.offence == null)
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            'Please select an offence',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // — Event type dropdown
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: row('Event Type *', form.eventType?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.eventType,
          items: dropdownItemBuilder(form.eventTypeOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.eventTypeOptions),
          hintText: 'Choose event type',
          validateBorder: validateOffenderEventTypeBorder,
          onChanged: (v) {
            if (!validateOffenderEventTypeBorder) {
              validateOffenderEventTypeBorder = true;
            }
            notifier.updateField('eventType', v!);
          },
        ),
      ),
      if (validateOffenderEventTypeBorder && form.eventType == null)
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            'Please select an event type',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // — Violation date picker
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: row(
          'Violation Date *',
          form.date.isNotEmpty
              ? formatDateShort(
                  DateTime.parse(form.date),
                  pattern: 'dd-MM-yyyy',
                )
              : form.date,
          context.wp,
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: GestureDetector(
          onTap: () async {
            if (isPreviewMode) return; // Disable in preview mode
            final picked = await showDatePicker(
              context: context,
              initialDate: form.date.isNotEmpty
                  ? DateTime.parse(form.date)
                  : DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              if (!validateOffenderViolationDateBorder) {
                validateOffenderViolationDateBorder = true;
              }
              notifier.updateField('date', picked.toIso8601String());
            }
          },
          child: AbsorbPointer(
            child: AppTextField(
              isPreviewMode: isPreviewMode,
              hintText: form.date.isEmpty
                  ? 'Select date'
                  : form.date.split('T').first,
              initialValue: form.date.isEmpty ? '' : form.date.split('T').first,
              validateBorder: validateOffenderViolationDateBorder,
              readOnly: true,
              keyboardType: TextInputType.datetime,
              suffix: Icon(
                Icons.calendar_today,
                color: AppColors.onBackgroundSurface2,
                size: context.wp(4),
              ),
            ),
          ),
        ),
      ),
      if (validateOffenderViolationDateBorder && form.date.isEmpty)
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            'Please choose a date',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // — Zone dropdown
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: row('Zone *', form.zone?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isPreviewMode: isPreviewMode,
          value: form.zone,
          items: dropdownItemBuilder(form.zoneOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.zoneOptions),
          hintText: 'Choose zone',
          validateBorder: validateOffenderZoneBorder,
          onChanged: (v) async {
            if (!validateOffenderZoneBorder) {
              validateOffenderZoneBorder = true;
            }
            // await notifier.updateField('command', null);
            await notifier.updateField('zone', v!);
          },
        ),
      ),
      if (validateOffenderZoneBorder && form.zone == null)
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            'Please select a zone',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // — Command dropdown
      Padding(
        padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
        child: row('Command *', form.command?.name ?? '', context.wp),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: AppDropdownField<DropdownOption>(
          isProcessing: form.isCommandLoading,
          isPreviewMode: isPreviewMode,
          value: form.command,
          items: dropdownItemBuilder(form.commandOptions),
          selectedItemBuilder: (_) => selectedBuilder(form.commandOptions),
          hintText: 'Choose command',
          validateBorder: validateOffenderCommandBorder,
          onChanged: (v) {
            if (!validateOffenderCommandBorder) {
              validateOffenderCommandBorder = true;
            }
            notifier.updateField('command', v!);
          },
        ),
      ),
      if (validateOffenderCommandBorder && form.command == null)
        Padding(
          padding: EdgeInsets.only(top: context.hp(0.5)),
          child: Text(
            'Please select a command',
            style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
          ),
        ),

      // END
    ];
    return !isPreviewMode
        ? ListView(
            padding: EdgeInsets.only(bottom: context.hp(2)),
            children: childrenArray,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childrenArray,
          );
  }

  Widget _mediaStep(
    WidgetRef ref,
    ViolationFormState form,
    ViolationNotifier notifier, {
    isPreviewMode = false,
  }) {
    // final media = form.mediaPaths;
    //array of widgets
    var childrenArray = <Widget>[
      // header
      Padding(
        padding: EdgeInsets.only(top: context.hp(1), bottom: context.hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Media Capture',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: isPreviewMode,
              child: GestureDetector(
                onTap: () => _back(step: ViolationStep.media),
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    // fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: !isPreviewMode,
        child: Text(
          'Evidence collection features',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      SizedBox(height: context.hp(2)),

      isPreviewMode
          ? const SizedBox()
          : Container(
              height: context.hp(18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(context.wp(2)),
                border: Border.all(color: AppColors.onBackgroundSurface2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Upload 10.0 MB maximum file size'),
                  SizedBox(height: context.hp(2)),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.wp(2)),
                      ),
                      foregroundColor: AppColors.onSurface,
                      side: BorderSide(color: AppColors.onBackgroundSurface2),
                    ),
                    icon: const Icon(Icons.file_upload_outlined),
                    label: const Text('Upload Media'),
                    onPressed: () => notifier.addMedia(context),
                  ),
                ],
              ),
            ),

      if (form.mediaPaths.isNotEmpty && !isPreviewMode) ...[
        SizedBox(height: context.hp(2)),
        Column(
          children: form.mediaPaths.map((item) {
            final double percent = 1.0;
            final fileName = item.split('/').last;
            return Padding(
              padding: EdgeInsets.only(bottom: context.hp(1)),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(context.wp(2)),
                child: Container(
                  padding: EdgeInsets.all(context.wp(3)),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(context.wp(2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // row: icon, name, size & status, check icon
                      Row(
                        children: [
                          // file icon
                          Container(
                            width: context.wp(10),
                            height: context.wp(10),
                            decoration: BoxDecoration(
                              color: AppColors.onBackgroundSurface2.withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              AppAssets.imagePlaceholder,
                              fit: BoxFit.contain,
                            ),
                            // ImageIcon(
                            //   AssetImage(AppAssets.imagePlaceholder),
                            //   size: context.wp(5),
                            //   color: AppColors.surface,
                            // ),
                            // Icon(
                            //   Icons.image, // or choose by extension
                            //   size: context.wp(6),
                            //   color: AppColors.onBackgroundSurface2,
                            // ),
                          ),
                          SizedBox(width: context.wp(3)),
                          // file info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  safeSubstring(fileName),
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: context.hp(0.5)),
                                Row(
                                  children: [
                                    Text(
                                      // '${(item.uploadedBytes / 1024).toStringAsFixed(0)}KB of '
                                      // '${(item.totalBytes / 1024).toStringAsFixed(0)}KB • '
                                      // '${item.isCompleted ? 'Completed' : 'Uploading'}',

                                      //static representation
                                      '1.2MB of 1.2MB • ',
                                      // 'Uploading'
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: context.wp(3.5),
                                            color:
                                                AppColors.onBackgroundSurface2,
                                          ),
                                    ),
                                    Text(
                                      'Completed' ?? 'Uploading...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: context.wp(3.5),
                                            color:
                                                AppColors.primary ??
                                                AppColors.onBackgroundSurface2,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // status icon
                          // if (item.isCompleted)
                          // Icon(Icons.check_circle, color: Colors.green),
                          IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  // remove this path
                                  final updated = List<String>.from(
                                    form.mediaPaths,
                                  )..remove(item);
                                  notifier.updateMediaPaths(updated);
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.onBackgroundSurface,
                                ),
                              ) ??
                              Icon(Icons.check_circle, color: Colors.green),
                        ],
                      ),
                      SizedBox(height: context.hp(1)),
                      // progress bar
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  // value: 1.0, // static representation
                                  minHeight: context.hp(1),
                                  backgroundColor: AppColors
                                      .onBackgroundSurface2
                                      .withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.wp(10),
                            child: Text(
                              '100%',
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: context.wp(3),
                                    color: AppColors.onBackgroundSurface2,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],

      SizedBox(height: context.hp(2)),
      // Expanded(
      //   child: Center(
      //     child: media.isEmpty
      //         ? OutlinedButton.icon(
      //             icon: const Icon(Icons.upload),
      //             label: const Text('Upload Media'),
      //             onPressed: () => notifier.addMedia(),
      //           )
      //         : Wrap(
      //             spacing: 8,
      //             runSpacing: 8,
      //             children: media
      //                 .map((path) => Image.file(File(path), width: 80))
      //                 .toList(),
      //           ),
      //   ),
      // ),
      isPreviewMode
          ? (form.mediaPaths.isEmpty
                ? const Text('None')
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: form.mediaPaths.map((p) {
                      return SizedBox(
                        width: context.wp(27),
                        height: context.wp(27),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.file(File(p), fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
                  ))
          : TextButton.icon(
              onPressed: () => notifier.addMedia(context),
              icon: const Icon(Icons.add),
              label: const Text('Add more media'),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
    ];

    return SingleChildScrollView(
      physics: isPreviewMode
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.hp(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childrenArray,
        ),
      ),
    );
  }

  Widget _reviewStep(ViolationFormState form, ViolationNotifier notifier) {
    return ListView(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      children: [
        Container(
          padding: EdgeInsets.all(context.wp(3)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wp(2)),
            color: AppColors.surface,
          ),
          child: _offenderVehicleStep(ref, form, notifier, isPreviewMode: true),
        ),
        const SizedBox(height: 15),

        Container(
          padding: EdgeInsets.all(context.wp(3)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wp(2)),
            color: AppColors.surface,
          ),
          child: _violationDetailsStep(
            ref,
            form,
            notifier,
            isPreviewMode: true,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(context.wp(3)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wp(2)),
            color: AppColors.surface,
          ),
          child: _mediaStep(ref, form, notifier, isPreviewMode: true),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
