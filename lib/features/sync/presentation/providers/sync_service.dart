import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/usecases/sync_offline_data.dart';
// import 'package:slts_enforcer_app/features/sync/presentation/providers/sync_service.dart'; // adjust path if needed

/// Exposes the use‑case that syncs all pending violations.
/// Simply call `ref.read(syncOfflineDataProvider)()` to kick off a background or manual sync.
final syncOfflineDataProvider = Provider<SyncOfflineData>(
  (ref) => SyncOfflineData(ref.read(syncRepositoryProvider)),
);
