import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';

/// Abstract contract for persisting a new violation.
abstract class ViolationRepository {
  /// Sends [req] to the backend.
  /// Throws a [Failure] on network or server errors.
  Future<void> createViolation(CreateViolationRequest req);

  /// Runs a plate number search; returns list of matches.
  Future<List<Violation>> runPlateNumber(String plate);
}
