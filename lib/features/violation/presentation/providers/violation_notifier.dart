import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/repositories/violation_repository.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../../../core/errors/failures.dart';

/// Holds the in‑progress form data.
class ViolationFormState {
  final String offence,
      eventType,
      date,
      zone,
      command,
      firstName,
      surname,
      phone;
  final String plate, plateType, plateColor, brand, vehicleType, vehicleColor;
  final List<String> mediaPaths;

  const ViolationFormState({
    this.offence = '',
    this.eventType = '',
    this.date = '',
    this.zone = '',
    this.command = '',
    this.firstName = '',
    this.surname = '',
    this.phone = '',
    this.plate = '',
    this.plateType = '',
    this.plateColor = '',
    this.brand = '',
    this.vehicleType = '',
    this.vehicleColor = '',
    this.mediaPaths = const [],
  });

  ViolationFormState copyWith({
    String? offence,
    String? eventType,
    String? date,
    String? zone,
    String? command,
    String? firstName,
    String? surname,
    String? phone,
    String? plate,
    String? plateType,
    String? plateColor,
    String? brand,
    String? vehicleType,
    String? vehicleColor,
    List<String>? mediaPaths,
  }) => ViolationFormState(
    offence: offence ?? this.offence,
    eventType: eventType ?? this.eventType,
    date: date ?? this.date,
    zone: zone ?? this.zone,
    command: command ?? this.command,
    firstName: firstName ?? this.firstName,
    surname: surname ?? this.surname,
    phone: phone ?? this.phone,
    plate: plate ?? this.plate,
    plateType: plateType ?? this.plateType,
    plateColor: plateColor ?? this.plateColor,
    brand: brand ?? this.brand,
    vehicleType: vehicleType ?? this.vehicleType,
    vehicleColor: vehicleColor ?? this.vehicleColor,
    mediaPaths: mediaPaths ?? this.mediaPaths,
  );
}

/// Manages form state + submission.
class ViolationNotifier extends StateNotifier<AsyncValue<ViolationFormState>> {
  final ViolationRepository repo;
  ViolationNotifier(this.repo)
    : super(const AsyncValue.data(ViolationFormState()));

  /// Update one of the form’s fields by key.
  void updateField(String key, String val) {
    final form = state.value!;
    ViolationFormState updated;

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
        updated = form.copyWith(zone: val);
        break;
      case 'command':
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

    state = AsyncValue.data(updated);
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
      await repo.createViolation(req);
      state = AsyncValue.data(form);
    } on Failure catch (f) {
      state = AsyncValue.error(f, StackTrace.current);
    }
  }
}

/// Provider
final violationNotifierProvider =
    StateNotifierProvider<ViolationNotifier, AsyncValue<ViolationFormState>>(
      (ref) => ViolationNotifier(ref.read(violationRepositoryProvider)),
    );
