import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';
import 'package:slts_enforcer_app/ui/widgets/app_dropdown_field.dart';
import 'package:slts_enforcer_app/ui/widgets/app_radio_dropdown.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
// import '../../data/models/create_violation_request.dart';
import '../providers/violation_notifier.dart';
import '../../../sync/presentation/providers/sync_service.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';

enum ViolationStep { offender, vehicle, media, review }

class CreateViolationScreen extends ConsumerStatefulWidget {
  const CreateViolationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateViolationScreen> createState() => _State();
}

class _State extends ConsumerState<CreateViolationScreen> {
  ViolationStep _step = ViolationStep.offender;
  var validateOffenderOffenceBorder = false,
      validateOffenderEventTypeBorder = false,
      validateOffenderViolationDateBorder = false,
      validateOffenderZoneBorder = false,
      validateOffenderCommandBorder = false,
      validateOffenderFirstNameBorder = false,
      validateOffenderSurnameBorder = false,
      validateOffenderPhoneBorder = false,
      validateVehiclePlateBorder = false,
      validateVehiclePlateTypeBorder = false,
      validateVehiclePlateColorBorder = false,
      validateVehicleBrandBorder = false,
      validateVehicleVehicleTypeBorder = false,
      validateVehicleVehicleColorBorder = false;

  void _next() => setState(() {
    _step = ViolationStep
        .values[(_step.index + 1).clamp(0, ViolationStep.values.length - 1)];
  });

  void _back() => setState(() {
    _step = ViolationStep
        .values[(_step.index - 1).clamp(0, ViolationStep.values.length - 1)];
  });

  Future<void> _save() async {
    final notifier = ref.read(violationNotifierProvider.notifier);
    try {
      // Attempt online submit
      await notifier.submit();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Violation submitted')));
    } on Failure catch (f) {
      if (f is NetworkFailure) {
        // Cache offline
        final form = ref.read(violationNotifierProvider).value!;
        final vModel = ViolationModel(
          offence: form.offence,
          eventType: form.eventType,
          date: form.date,
          zone: form.zone,
          command: form.command,
          firstName: form.firstName,
          surname: form.surname,
          phone: form.phone,
          plate: form.plate,
          plateType: form.plateType,
          plateColor: form.plateColor,
          brand: form.brand,
          vehicleType: form.vehicleType,
          vehicleColor: form.vehicleColor,
          mediaPaths: form.mediaPaths,
        );
        await ref.read(syncOfflineDataProvider)();
        // Note: syncOfflineData does the actual save via repository
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No connection—saved offline')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(f.displayMessage)));
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp, hp = context.hp;
    final formValue = ref.watch(violationNotifierProvider).value!;
    final isLoading = ref.watch(violationNotifierProvider).isLoading;

    // Titles per step
    const titles = {
      ViolationStep.offender: 'Offender Details',
      ViolationStep.vehicle: 'Vehicle Info',
      ViolationStep.media: 'Media Capture',
      ViolationStep.review: 'Review',
    };

    // Step widgets
    final pages = [
      _offenderStep(ref, formValue),
      _vehicleStep(ref, formValue),
      _mediaStep(ref, formValue),
      _reviewStep(formValue),
    ];

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: Column(
              children: [
                OverlayHeader(
                  title: titles[_step]!,
                  onBack: _step == ViolationStep.offender
                      ? () => Navigator.of(context).pop()
                      : _back,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wp(4),
                      vertical: hp(2),
                    ),
                    child: IndexedStack(index: _step.index, children: pages),
                  ),
                ),
                // Bottom row
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: wp(4),
                    vertical: hp(2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _step == ViolationStep.offender
                              ? null
                              : _back,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.onBackgroundSurface2,
                            ),
                            padding: EdgeInsets.symmetric(vertical: hp(2)),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                      SizedBox(width: wp(4)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : (_step == ViolationStep.review ? _save : _next),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: hp(2)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(wp(2)),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  _step == ViolationStep.review
                                      ? 'Save'
                                      : 'Next',
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _offenderStep(WidgetRef ref, ViolationFormState form) {
    final notifier = ref.read(violationNotifierProvider.notifier);

    // dropdown options
    const offenceOptions = ['Overspeeding', 'Illegal Parking', 'Signal Jump'];
    const eventTypeOptions = ['Minor', 'Major'];
    const zoneOptions = ['Lagos', 'Abuja', 'Kano'];
    const commandOptions = ['Command HQ', 'Sector 1', 'Sector 2'];

    return ListView(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      children: [
        // header
        Padding(
          padding: EdgeInsets.only(top: context.hp(1), bottom: context.hp(1)),
          child: Text(
            'Offender Details',
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          'Information captured about the person committing the offense.',
          style: Theme.of(context).textTheme.bodySmall,
        ),

        // — Offence dropdown
        Padding(
          padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
          child: Text(
            'Select Offence *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // AppRadioDropdown<String>(
        //   value: form.offence.isEmpty ? null : form.offence,
        //   options: offenceOptions,
        //   itemLabel: (o) => o,
        //   hintText: 'Overspeeding',
        //   showError: validateOffenderOffenceBorder,
        //   onChanged: (v) {
        //     if (!validateOffenderOffenceBorder) {
        //       validateOffenderOffenceBorder = true;
        //     }
        //     notifier.updateField('offence', v!);
        //   },
        // ),
        // SizedBox(height: context.hp(1)),
        AppDropdownField<String>(
          value: form.offence.isEmpty ? null : form.offence,
          items: offenceOptions
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          hintText: 'Choose an offence',
          validateBorder: validateOffenderOffenceBorder,
          onChanged: (v) {
            if (!validateOffenderOffenceBorder) {
              validateOffenderOffenceBorder = true;
            }
            notifier.updateField('offence', v!);
          },
        ),
        if (validateOffenderOffenceBorder && form.offence.isEmpty)
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
          child: Text(
            'Select Event Type *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppDropdownField<String>(
          value: form.eventType.isEmpty ? null : form.eventType,
          items: eventTypeOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          hintText: 'Choose event type',
          validateBorder: validateOffenderEventTypeBorder,

          onChanged: (v) {
            if (!validateOffenderEventTypeBorder) {
              validateOffenderEventTypeBorder = true;
            }
            notifier.updateField('eventType', v!);
          },
        ),
        if (validateOffenderEventTypeBorder && form.eventType.isEmpty)
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
          child: Text(
            'Select Violation Date *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        GestureDetector(
          onTap: () async {
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
          child: Text(
            'Select Zone *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppDropdownField<String>(
          value: form.zone.isEmpty ? null : form.zone,
          items: zoneOptions
              .map((z) => DropdownMenuItem(value: z, child: Text(z)))
              .toList(),
          hintText: 'Choose zone',
          validateBorder: validateOffenderZoneBorder,

          onChanged: (v) {
            if (!validateOffenderZoneBorder) {
              validateOffenderZoneBorder = true;
            }
            notifier.updateField('zone', v!);
          },
        ),
        if (validateOffenderZoneBorder && form.zone.isEmpty)
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
          child: Text(
            'Select Command *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppDropdownField<String>(
          value: form.command.isEmpty ? null : form.command,
          items: commandOptions
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          hintText: 'Choose command',
          validateBorder: validateOffenderCommandBorder,

          onChanged: (v) {
            if (!validateOffenderCommandBorder) {
              validateOffenderCommandBorder = true;
            }
            notifier.updateField('command', v!);
          },
        ),
        if (validateOffenderCommandBorder && form.command.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: context.hp(0.5)),
            child: Text(
              'Please select a command',
              style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
            ),
          ),

        // — First name
        Padding(
          padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
          child: Text(
            'Offender First Name *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppTextField(
          hintText: 'Olukunle',
          initialValue: form.firstName,
          validateBorder: validateOffenderFirstNameBorder,
          onChanged: (v) {
            if (!validateOffenderFirstNameBorder) {
              validateOffenderFirstNameBorder = true;
            }
            notifier.updateField('firstName', v);
          },
        ),
        if (validateOffenderFirstNameBorder && form.firstName.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: context.hp(0.5)),
            child: Text(
              'Please enter first name',
              style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
            ),
          ),

        // — Surname
        Padding(
          padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
          child: Text(
            'Offender Surname *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppTextField(
          hintText: 'Oyewumi',
          initialValue: form.surname,
          validateBorder: validateOffenderSurnameBorder,
          onChanged: (v) {
            if (!validateOffenderSurnameBorder) {
              validateOffenderSurnameBorder = true;
            }
            notifier.updateField('surname', v);
          },
        ),
        if (validateOffenderSurnameBorder && form.surname.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: context.hp(0.5)),
            child: Text(
              'Please enter surname',
              style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
            ),
          ),

        // — Phone
        Padding(
          padding: EdgeInsets.only(top: context.hp(2), bottom: context.hp(0.5)),
          child: Text(
            'Phone Number *',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        AppTextField(
          hintText: '+234 81...',
          initialValue: form.phone,
          keyboardType: TextInputType.phone,
          validateBorder: validateOffenderPhoneBorder,
          onChanged: (v) {
            if (!validateOffenderPhoneBorder) {
              validateOffenderPhoneBorder = true;
            }
            notifier.updateField('phone', v);
          },
        ),
        if (validateOffenderPhoneBorder && form.phone.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: context.hp(0.5)),
            child: Text(
              'Please enter phone number',
              style: TextStyle(color: AppColors.error, fontSize: context.wp(3)),
            ),
          ),
      ],
    );
  }

  Widget _vehicleStep(WidgetRef ref, ViolationFormState form) {
    return ListView(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      children: [
        const Text('Enter Plate Number *'),
        AppTextField(
          hintText: 'KSF-622AE',
          initialValue: form.plate,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('plate', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Plate Type *'),
        AppTextField(
          hintText: 'Local',
          initialValue: form.plateType,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('plateType', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Plate Color *'),
        AppTextField(
          hintText: 'Blue',
          initialValue: form.plateColor,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('plateColor', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Vehicle Brand *'),
        AppTextField(
          hintText: 'Toyota',
          initialValue: form.brand,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('brand', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Vehicle Type *'),
        AppTextField(
          hintText: '4 Door',
          initialValue: form.vehicleType,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('vehicleType', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Vehicle Color *'),
        AppTextField(
          hintText: 'Yellow',
          initialValue: form.vehicleColor,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('vehicleColor', v),
        ),
      ],
    );
  }

  Widget _mediaStep(WidgetRef ref, ViolationFormState form) {
    final notifier = ref.read(violationNotifierProvider.notifier);
    final media = form.mediaPaths;
    return Column(
      children: [
        const Text('Upload Media (max 10 MB)'),
        SizedBox(height: context.hp(2)),
        Expanded(
          child: Center(
            child: media.isEmpty
                ? OutlinedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Media'),
                    onPressed: () => notifier.addMedia(),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: media
                        .map((path) => Image.file(File(path), width: 80))
                        .toList(),
                  ),
          ),
        ),
        TextButton.icon(
          onPressed: () => notifier.addMedia(),
          icon: const Icon(Icons.add),
          label: const Text('Add more media'),
        ),
      ],
    );
  }

  Widget _reviewStep(ViolationFormState form) {
    return ListView(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      children: [
        const Text(
          'Offender Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Offence: ${form.offence}'),
        // ... all offender details ...
        const SizedBox(height: 16),
        const Text(
          'Vehicle Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Plate: ${form.plate}'),
        // ... all vehicle details ...
        const SizedBox(height: 16),
        const Text('Media', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (form.mediaPaths.isEmpty)
          const Text('None')
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: form.mediaPaths
                .map((p) => Image.file(File(p), width: 80))
                .toList(),
          ),
      ],
    );
  }
}
