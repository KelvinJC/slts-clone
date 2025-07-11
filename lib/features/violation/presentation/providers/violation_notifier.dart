import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/repositories/violation_repository.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/violation_form_state.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../../../core/errors/failures.dart';

/// Manages form state + all dropdown loading + media + submission.
class ViolationNotifier extends StateNotifier<AsyncValue<ViolationFormState>> {
  final ViolationRepository _repo;
  final LocalStorage _storage;

  ViolationNotifier(this._repo, this._storage)
    : super(AsyncValue.data(ViolationFormState.initial())) {
    _loadAllSettings();
  }

  /// 1) Fetch all “settings” lists from the server on startup.
  Future<void> _loadAllSettings() async {
    final form = state.value!;
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

      state = AsyncValue.data(
        form.copyWith(
          offenceOptions: offences,
          eventTypeOptions: events,
          zoneOptions: zones,
          vehicleBrandOptions: vehicleBrands,
          vehicleColorOptions: vehicleColors,
          vehicleTypeOptions: vehicleTypes,
          plateTypeOptions: plateTypes,
          plateColorOptions: plateColors,
        ),
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

      state = AsyncValue.data(
        form.copyWith(
          offenceOptions: offences,
          eventTypeOptions: events,
          zoneOptions: zones,
          vehicleBrandOptions: vehicleBrands,
          vehicleColorOptions: vehicleColors,
          vehicleTypeOptions: vehicleTypes,
          plateTypeOptions: plateTypes,
          plateColorOptions: plateColors,
        ),
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
    final form = state.value!;
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
        updated = form.copyWith(zone: val, command: null, commandOptions: []);
        state = AsyncValue.data(updated);
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
      case 'plate':
        updated = form.copyWith(plate: val);
        break;
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

    if (!breakLoop) state = AsyncValue.data(updated);
  }

  /// 3) When the user picks a zone, fetch its commands.
  Future<void> _loadCommandsForZone(DropdownOption zone) async {
    final form = state.value!;
    try {
      final cmds = await _repo.fetchCommandListForZone(zone.id);
      await _storage.writeJsonList(
        'commands_zone_${zone.id}',
        cmds.map((c) => c.toJson()).toList(),
      );
      state = AsyncValue.data(
        form.copyWith(commandOptions: cmds, command: null),
      );
    } on Failure catch (f) {
      print('Failed to load commands: $f');
      // state = AsyncValue.error(f, StackTrace.current);
      // fallback
      final raw = await _storage.readJsonList('commands_zone_${zone.id}') ?? [];
      final cmds = raw.map((m) => DropdownOption.fromJson(m)).toList();
      state = AsyncValue.data(
        form.copyWith(commandOptions: cmds, command: null),
      );
    }
  }

  /// Pick images via camera or gallery.
  Future<void> addMedia() async {
    final picker = ImagePicker();
    final pic = await picker.pickImage(source: ImageSource.camera);
    if (pic != null) {
      final form = state.value!;
      state = AsyncValue.data(
        form.copyWith(mediaPaths: [...form.mediaPaths, pic.path]),
      );
    }
  }

  // Update state with new media paths
  Future<void> updateMediaPaths(List<String> paths) async {
    final form = state.value!;
    state = AsyncValue.data(form.copyWith(mediaPaths: paths));
  }

  /// Submit the full violation.
  Future<void> submit() async {
    final form = state.value!;

    state = AsyncValue.loading();
    try {
      final req = CreateViolationRequest(
        zoneId: form.zone!.id.toString(),
        commandId: form.command!.id.toString(),
        offenceId: form.offence!.id.toString(),
        firstName: form.firstName,
        surname: form.surname,
        phoneNumber: form.phone,
        emailAddress: 'form.email',
        plateColorId: form.plateColor!.id.toString(),
        plateTypeId: form.plateType!.id.toString(),
        eventTypeId: form.eventType!.id.toString(),
        vehicleBrandId: form.brand!.id.toString(),
        vehicleColorId: form.vehicleColor!.id.toString(),
        vehicleTypeId: form.vehicleType!.id.toString(),
        pcn: 'form.pcn',
        plateNo: form.plate,
        violationDate: form.date,
        paymentAmount: 'form.paymentAmount.toString()',
        sltsAmount: 'form.sltsAmount.toString()',
        clientAmount: 'form.clientAmount.toString()',
        insertedBy: 'form.insertedBy',
      );
      await _repo.createViolation(req);
      state = AsyncValue.data(form);
      resetFormFields();
    } on Failure catch (f) {
      state = AsyncValue.error(f, StackTrace.current);
    }
  }

  /// Clears *only* the user‐entered fields and media, but preserves all the
  /// pre‐loaded settings lists (offenceOptions, zoneOptions, etc).
  void resetFormFields() {
    final form = state.value!;
    state = AsyncValue.data(
      form.copyWith(
        offence: null,
        eventType: null,
        date: '',
        zone: null,
        command: null,
        firstName: '',
        surname: '',
        phone: '',
        plate: '',
        plateType: null,
        plateColor: null,
        brand: null,
        vehicleType: null,
        vehicleColor: null,
        mediaPaths: [],
      ),
    );
  }
}

/// Provider
final violationNotifierProvider =
    StateNotifierProvider<ViolationNotifier, AsyncValue<ViolationFormState>>(
      (ref) => ViolationNotifier(
        ref.read(violationRepositoryProvider),
        ref.read(localStorageProvider),
      ),
    );
