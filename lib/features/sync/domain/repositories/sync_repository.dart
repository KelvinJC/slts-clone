import 'package:slts_enforcer_app/features/violation/data/models/violation_hive_model.dart';

/// Defines methods for saving & syncing offline data.
abstract class SyncRepository {
  /// Save a violation locally for later sync.
  Future<void> saveOfflineViolation(ViolationHiveModel v);

  /// Attempt to sync all saved violations to the server.
  Future<void> syncPendingViolations();
}
