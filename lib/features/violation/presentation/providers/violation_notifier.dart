import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/features/sync/domain/repositories/sync_repository.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/domain/repositories/violation_repository.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/violation_form_state.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../../../core/errors/failures.dart';

/// A shortcut to read other providers from inside this notifier.
typedef Reader = T Function<T>(ProviderListenable<T> provider);

/// Manages form state + all dropdown loading + media + submission.
class ViolationNotifier extends StateNotifier<ViolationFormState> {
  final ViolationRepository _repo;
  final SyncRepository _syncRepo;
  final TextEditingController plateNoController;
  final FocusNode plateNoFocusNode;
  List<Violation> list = [];
  final LocalStorage _storage;
  final Reader _read;

  ViolationNotifier(this._repo, this._syncRepo, this._storage, this._read)
    : plateNoController = TextEditingController(),
      plateNoFocusNode = FocusNode(),
      super(ViolationFormState.initial()) {
    // _loadAllSettings();
  }

  Future<void> search({bool isNext = false}) async {
    final plate = plateNoController.text.trim();
    if (plate.isEmpty) return;

    if (plate == state.plate) {
      // No change, skip search
      return;
    }

    if (!isNext) {
      // clear state
      resetFormFields();
    }

    state = state.copyWith(plateNoLoading: true, error: null);
    try {
      list = await _repo.runPlateNumber(plate);
      if (list.isNotEmpty) {
        await loadSettings(v: list.first, skipLoading: true);
        state = state.copyWith(plateNoLoading: false);
      } else {
        // clear state
        resetFormFields();
        state = state.copyWith(
          plateNoLoading: false,
          error: UnexpectedFailure(rawMessage: 'No record found for $plate'),
        );
      }
    } on Failure catch (f) {
      if (isNext) {
        // clear state
        resetFormFields();
      }
      state = state.copyWith(plateNoLoading: false, error: f);
    }
  }

  @override
  void dispose() {
    plateNoFocusNode.dispose();
    plateNoController.dispose();
    super.dispose();
  }

  /// 1) Fetch all “settings” lists from the server on startup.
  Future<void> _loadAllSettings() async {
    final form = state;
    try {
      final offences = await _repo.fetchOffenceList();
      final events = await _repo.fetchEventTypeList();
      final zones = await _repo.fetchZoneList();
      final vehicleBrands = await _repo.fetchVehicleBrandList();
      final vehicleColors = await _repo.fetchVehicleColorList();
      final vehicleTypes = await _repo.fetchVehicleTypeList();
      final plateTypes = await _repo.fetchPlateTypeList();
      final plateColors = await _repo.fetchPlateColorList();

      // cache locally
      await _storage.writeJsonList(
        'offences',
        offences.map((o) => o.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'events',
        events.map((e) => e.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'zones',
        zones.map((z) => z.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'vehicleBrands',
        vehicleBrands.map((z) => z.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'vehicleColors',
        vehicleColors.map((z) => z.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'vehicleTypes',
        vehicleTypes.map((z) => z.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'plateTypes',
        plateTypes.map((z) => z.toJson()).toList(),
      );
      await _storage.writeJsonList(
        'plateColors',
        plateColors.map((z) => z.toJson()).toList(),
      );

      state = form.copyWith(
        offenceOptions: offences,
        eventTypeOptions: events,
        zoneOptions: zones,
        vehicleBrandOptions: vehicleBrands,
        vehicleColorOptions: vehicleColors,
        vehicleTypeOptions: vehicleTypes,
        plateTypeOptions: plateTypes,
        plateColorOptions: plateColors,
      );
    } on Failure catch (f) {
      print('Failed to load settings: $f');
      // state = AsyncValue.error(f, StackTrace.current);
      // fallback to cache
      final offences = await _loadCachedOptions('offences');
      final events = await _loadCachedOptions('events');
      final zones = await _loadCachedOptions('zones');
      final vehicleBrands = await _loadCachedOptions('vehicleBrands');
      final vehicleColors = await _loadCachedOptions('vehicleColors');
      final vehicleTypes = await _loadCachedOptions('vehicleTypes');
      final plateTypes = await _loadCachedOptions('plateTypes');
      final plateColors = await _loadCachedOptions('plateColors');

      state = form.copyWith(
        offenceOptions: offences,
        eventTypeOptions: events,
        zoneOptions: zones,
        vehicleBrandOptions: vehicleBrands,
        vehicleColorOptions: vehicleColors,
        vehicleTypeOptions: vehicleTypes,
        plateTypeOptions: plateTypes,
        plateColorOptions: plateColors,
      );
    }
  }

  Future<List<DropdownOption>> _loadCachedOptions(String key) async {
    final raw = await _storage.readJsonList(key) ?? [];
    return raw.map((m) => DropdownOption.fromJson(m)).toList();
  }

  /// 2) Update any single field by key.
  ///
  /// If you ever set `zoneId`, it will automatically re‐fetch
  /// that zone’s commands and clear the old selection.
  Future<void> updateField(String key, dynamic val) async {
    // print('Updating field: $key = $val');
    final form = state;
    ViolationFormState updated = form;
    bool breakLoop = false;

    switch (key) {
      case 'offence':
        updated = form.copyWith(offence: val);
        break;
      case 'eventType':
        updated = form.copyWith(eventType: val);
        break;
      case 'date':
        updated = form.copyWith(date: val);
        break;
      case 'zone':
        breakLoop = true;
        updated = form.copyWith(
          zone: val,
          isCommandLoading: true,
          command: null,
          commandOptions: [],
        );
        state = updated;
        await _loadCommandsForZone(val);
        break;
      case 'command':
        if (val == null) updated = form.copyWith(commandOptions: []);
        updated = form.copyWith(command: val);
        break;
      case 'firstName':
        updated = form.copyWith(firstName: val);
        break;
      case 'surname':
        updated = form.copyWith(surname: val);
        break;
      case 'phone':
        updated = form.copyWith(phone: val);
        break;
      case 'email':
        updated = form.copyWith(email: val);
        break;
      // case 'plate':
      //   updated = form.copyWith(plate: val);
      //   break;
      case 'plateType':
        updated = form.copyWith(plateType: val);
        break;
      case 'plateColor':
        updated = form.copyWith(plateColor: val);
        break;
      case 'brand':
        updated = form.copyWith(brand: val);
        break;
      case 'vehicleType':
        updated = form.copyWith(vehicleType: val);
        break;
      case 'vehicleColor':
        updated = form.copyWith(vehicleColor: val);
        break;
      default:
        // Unknown key: leave unchanged
        updated = form;
    }

    if (!breakLoop) state = updated;
  }

  /// 3) When the user picks a zone, fetch its commands.
  Future<void> _loadCommandsForZone(DropdownOption zone) async {
    final form = state;
    try {
      final cmds = await _repo.fetchCommandListForZone(zone.id);
      await _storage.writeJsonList(
        'commands_zone_${zone.id}',
        cmds.map((c) => c.toJson()).toList(),
      );
      state = form.copyWith(
        commandOptions: cmds,
        command: null,
        isCommandLoading: false,
      );
    } on Failure catch (f) {
      print('Failed to load commands: $f');
      // state = AsyncValue.error(f, StackTrace.current);
      // fallback
      final raw = await _storage.readJsonList('commands_zone_${zone.id}') ?? [];
      final cmds = raw.map((m) => DropdownOption.fromJson(m)).toList();
      state = form.copyWith(
        commandOptions: cmds,
        command: null,
        isCommandLoading: false,
      );
    }
  }

  /// Pick images via camera or gallery.
  Future<void> addMedia(BuildContext context) async {
    // Step 1: choose source
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take Photo'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ],
      ),
    );
    if (source == null) return;

    final picker = ImagePicker();
    final pic = await picker.pickImage(source: source);
    if (pic != null) {
      final form = state;
      state = form.copyWith(mediaPaths: [...form.mediaPaths, pic.path]);
    }
  }

  // Update state with new media paths
  Future<void> updateMediaPaths(List<String> paths) async {
    final form = state;
    state = form.copyWith(mediaPaths: paths);
  }

  /// Submit the full violation.
  Future<bool?> submit() async {
    final form = state;
    state = state.copyWith(isSubmitting: true, error: null);
    // 1️⃣ Convert each local file path into a Base64‐encoded string
    final files = await Future.wait(
      state.mediaPaths.map((path) async {
        final bytes = await File(path).readAsBytes();
        return base64Encode(bytes);
      }),
    );

    final req = CreateViolationRequest(
      zoneId: form.zone!.id.toString(),
      commandId: form.command!.id.toString(),
      offenceId: form.offence!.id.toString(),
      offenderId: form.offenderId ?? '',
      firstName: form.firstName,
      surname: form.surname,
      phoneNumber: form.phone,
      emailAddress: form.email,
      plateColorId: form.plateColor!.id.toString(),
      plateTypeId: form.plateType!.id.toString(),
      eventTypeId: form.eventType!.id.toString(),
      vehicleBrandId: form.brand!.id.toString(),
      vehicleColorId: form.vehicleColor!.id.toString(),
      vehicleTypeId: form.vehicleType!.id.toString(),
      pcn: list.isNotEmpty ? list.first.pcnNumber : '',
      plateNo: form.plate,
      violationDate: form.date,
      paymentAmount: form.offence?.amount.toString() ?? '0',
      // sltsAmount: list.isNotEmpty ? list.first.sltsAmount.toString() : '0.0',
      // clientAmount: list.isNotEmpty
      //     ? list.first.clientAmount.toString()
      //     : '0.0',
      insertedBy: _read(authNotifierProvider).user?.id.toString() ?? '0',
      files: files,
    );

    try {
      await _repo.createViolation(req);
      // state = AsyncValue.data(form);
      state = state.copyWith(isSubmitting: false, error: null);
      resetFormFields(clearController: true);

      return true;
    } on Failure catch (f) {
      if (f is NetworkFailure) {
        // Cache offline
        final vHiveModel = req.toViolationHiveModel();
        await _syncRepo.saveOfflineViolation(vHiveModel);

        state = state.copyWith(isSubmitting: false);
        resetFormFields(clearController: true);

        return false;
      }

      state = state.copyWith(isSubmitting: false, error: f);
      return null;
    } on Exception catch (e) {
      print('Error submitting violation: $e');
      state = state.copyWith(
        isSubmitting: false,
        error: UnexpectedFailure(rawMessage: e.toString()),
      );
      return null;
    }
  }

  /// Clears *only* the user‐entered fields and media, but preserves all the
  /// pre‐loaded settings lists (offenceOptions, zoneOptions, etc).
  void resetFormFields({bool clearController = false}) {
    if (clearController) {
      plateNoController.clear();
    }

    list.clear();
    state = state.copyWith(
      plateType: DropdownOption.empty(),
      plateColor: DropdownOption.empty(),
      brand: DropdownOption.empty(),
      vehicleType: DropdownOption.empty(),
      vehicleColor: DropdownOption.empty(),
      //
      firstName: '',
      surname: '',
      phone: '',
      email: '',
      //
      offenderId: '',
      offence: DropdownOption.empty(),
      eventType: DropdownOption.empty(),
      date: '',
      zone: DropdownOption.empty(),
      command: DropdownOption.empty(),
      mediaPaths: [],
    );
  }

  void resetErrors() {
    // print('Resetting errors');
    state = state.copyWith(error: null, loading: false);
  }

  Future<void> loadSettings({Violation? v, bool skipLoading = false}) async {
    state = state.copyWith(loading: skipLoading ? false : true, error: null);
    if (v != null) {
      // Set the plate number in the controller
      plateNoController.clear();
      plateNoController.text = v.plateNumber;

      // Clear the list and add the selected violation
      list.clear();
      list = [v];

      state = state.copyWith(
        plate: v.plateNumber,
        plateType: DropdownOption(v.plateTypeId, v.plateTypeName, null),
        plateColor: DropdownOption(v.plateColorId, v.plateColorName, null),
        brand: DropdownOption(v.vehicleBrandId, v.vehicleBrandName, null),
        vehicleType: DropdownOption(v.vehicleTypeId, v.vehicleTypeName, null),
        vehicleColor: DropdownOption(
          v.vehicleColorId,
          v.vehicleColorName,
          null,
        ),
        //
        firstName: v.firstName,
        surname: v.surname,
        phone: v.phoneNumber,
        email: v.emailAddress,
        //
        offenderId: v.offenderId.toString(),
        // offence: DropdownOption(
        //   v.offenceId,
        //   v.offenceName,
        //   v.amount.toDouble(),
        // ),
        // eventType: DropdownOption(v.eventTypeId, v.eventTypeName, null),
        // date: v.violationDate.toIso8601String(),
        // zone: DropdownOption(v.zoneId, v.zoneName, null),
        // command: DropdownOption(v.commandId, v.commandName, null),
      );
    }
    //  else {
    await _loadAllSettings();
    // }
    state = state.copyWith(loading: false, error: null);
  }
}

/// Provider
final violationNotifierProvider =
    StateNotifierProvider<ViolationNotifier, ViolationFormState>(
      (ref) => ViolationNotifier(
        ref.read(violationRepositoryProvider),
        ref.read(syncRepositoryProvider),
        ref.read(localStorageProvider),
        ref.read,
      ),
    );
