import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';
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
    return ListView(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      children: [
        const Text('Select Offence *'),
        AppTextField(
          hintText: 'Overspeeding',
          initialValue: form.offence,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('offence', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Event Type *'),
        AppTextField(
          hintText: 'Minor',
          initialValue: form.eventType,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('eventType', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Violation Date *'),
        AppTextField(
          hintText: '20-15-2024',
          initialValue: form.date,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('date', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Zone *'),
        AppTextField(
          hintText: 'Lagos',
          initialValue: form.zone,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('zone', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Select Command *'),
        AppTextField(
          hintText: 'Command HQ',
          initialValue: form.command,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('command', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Offender First Name *'),
        AppTextField(
          hintText: 'Olukunle',
          initialValue: form.firstName,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('firstName', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Offender Surname *'),
        AppTextField(
          hintText: 'Oyewumi',
          initialValue: form.surname,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('surname', v),
        ),
        SizedBox(height: context.hp(2)),

        const Text('Phone Number *'),
        AppTextField(
          hintText: '+234 81...',
          initialValue: form.phone,
          keyboardType: TextInputType.phone,
          onChanged: (v) => ref
              .read(violationNotifierProvider.notifier)
              .updateField('phone', v),
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
                    onPressed: () =>
                        ref.read(violationNotifierProvider.notifier).addMedia(),
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
          onPressed: () =>
              ref.read(violationNotifierProvider.notifier).addMedia(),
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
