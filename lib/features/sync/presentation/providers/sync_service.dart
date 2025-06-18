import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/sync/data/data_sources/local_violation_data_source.dart';
import 'package:slts_enforcer_app/features/sync/data/repositories_impl/sync_repository_impl.dart';
import 'package:slts_enforcer_app/features/sync/domain/repositories/sync_repository.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/usecases/sync_offline_data.dart';

/// 1) Local DS provider
final localDsProvider = Provider((_) => LocalViolationDataSource());

/// 2) SyncRepository provider
final syncRepoProvider = Provider<SyncRepository>((ref) {
  return SyncRepositoryImpl(ref.watch(apiProvider), ref.watch(localDsProvider));
});

/// 3) Use‑case provider
final syncOfflineDataProvider = Provider((ref) {
  return SyncOfflineData(ref.watch(syncRepoProvider));
});

/// 4) Service you call to kick off sync
final syncServiceProvider = Provider((ref) {
  return ref.watch(syncOfflineDataProvider);
});
