import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/violation_form_state.dart';

/// Abstract contract for persisting a new violation.
abstract class ViolationRepository {
  /// Settings lists
  Future<List<DropdownOption>> fetchVehicleBrandList();
  Future<List<DropdownOption>> fetchVehicleColorList();
  Future<List<DropdownOption>> fetchVehicleTypeList();
  Future<List<DropdownOption>> fetchPlateTypeList();
  Future<List<DropdownOption>> fetchPlateColorList();
  Future<List<DropdownOption>> fetchOffenceList();
  Future<List<DropdownOption>> fetchEventTypeList();
  Future<List<DropdownOption>> fetchZoneList();
  Future<List<DropdownOption>> fetchCommandListForZone(int zoneId);

  /// Sends [req] to the backend.
  /// Throws a [Failure] on network or server errors.
  Future<void> createViolation(CreateViolationRequest req);

  /// Runs a plate number search; returns list of matches.
  Future<List<Violation>> runPlateNumber(String plate);
}
