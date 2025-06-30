import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';

/// Abstract contract for persisting a new violation.
abstract class ViolationRepository {
  /// Sends [req] to the backend.
  /// Throws a [Failure] on network or server errors.
  Future<void> createViolation(CreateViolationRequest req);
}
