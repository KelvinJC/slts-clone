import '../../domain/repositories/sync_repository.dart';

/// A use‑case that, when invoked, will attempt to upload all
/// cached violations to the server.
class SyncOfflineData {
  final SyncRepository _repo;

  SyncOfflineData(this._repo);

  /// Executes the sync. Throws if something catastrophic happens,
  /// otherwise will have pruned any successfully‐sent items from local storage.
  Future<void> call() => _repo.syncPendingViolations();
}
