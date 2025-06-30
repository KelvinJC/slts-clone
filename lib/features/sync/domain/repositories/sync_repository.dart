import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';

/// Defines methods for saving & syncing offline data.
abstract class SyncRepository {
  /// Save a violation locally for later sync.
  Future<void> saveOfflineViolation(ViolationModel v);

  /// Attempt to sync all saved violations to the server.
  Future<void> syncPendingViolations();
}
