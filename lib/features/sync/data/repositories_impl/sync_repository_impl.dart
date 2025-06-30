import 'dart:convert';

import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import '../../domain/repositories/sync_repository.dart';

/// The key under which we store pending violations in secure storage.
const _offlineKey = 'offline_violations';

class SyncRepositoryImpl implements SyncRepository {
  final AppApi _api;
  final LocalStorage _storage;

  SyncRepositoryImpl(this._api, this._storage);

  /// Called by your create‑violation use‑case when offline:
  @override
  Future<void> saveOfflineViolation(ViolationModel v) async {
    // 1) Read existing list
    final raw = await _storage.read(_offlineKey) ?? '[]';
    final List<dynamic> list = jsonDecode(raw);

    // 2) Append new request JSON
    final req = CreateViolationRequest.fromViolationModel(v);
    list.add(req.toJson());

    // 3) Save back
    await _storage.write(_offlineKey, jsonEncode(list));
  }

  /// Called periodically (e.g. via BackgroundFetch) to push cached violations.
  @override
  Future<void> syncPendingViolations() async {
    final raw = await _storage.read(_offlineKey) ?? '[]';
    final List<dynamic> list = jsonDecode(raw);

    if (list.isEmpty) return;

    final List<Map<String, dynamic>> remaining = [];

    for (final item in list) {
      try {
        // rehydrate the request
        final req = CreateViolationRequest.fromJson(
          Map<String, dynamic>.from(item),
        );
        // attempt API call
        await _api.createViolation(req);
        // on success: do *not* add back to `remaining`
      } catch (_) {
        // on failure: keep it in the queue
        remaining.add(Map<String, dynamic>.from(item));
      }
    }

    // write back only the ones that failed
    await _storage.write(_offlineKey, jsonEncode(remaining));
  }
}
