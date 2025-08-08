import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/action_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/resend_link_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/pagination.dart';
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

  /// Gets recent captures
  Future<(List<Violation>, Pagination?)> getRecentCaptures(
    int userId, {
    int page = 1,
    int limit = 10,
  });

  /// Gets patrol mode
  Future<(List<Violation>, Pagination?)> getPatrolMode(
    int userId, {
    int page = 1,
    int limit = 10,
  });

  /// submit resend link
  Future<void> submitResendLink(ResendLinkRequest req);

  /// submit action
  Future<void> submitAction(ActionRequest req);
}
