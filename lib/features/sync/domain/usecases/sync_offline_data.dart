import '../repositories/sync_repository.dart';

class SyncOfflineData {
  final SyncRepository _repo;
  SyncOfflineData(this._repo);

  Future<void> call() async {
    await _repo.syncViolations();
  }
}
