// import '../models/violation_model.dart';

abstract class SyncRepository {
  /// Uploads all cached violations to server; clears local on success.
  Future<void> syncViolations();
}
