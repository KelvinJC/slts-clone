import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';

import '../data_sources/local_violation_data_source.dart';
import '../../domain/repositories/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  final AppApi _api;
  final LocalViolationDataSource _localDs;

  SyncRepositoryImpl(this._api, this._localDs);

  @override
  Future<void> syncViolations() async {
    final list = await _localDs.fetchAll();
    if (list.isEmpty) return;

    for (var v in list) {
      final req = CreateViolationRequest.fromViolationModel(v);
      await _api.createViolation(req);
      // optionally handle photo upload here...
    }

    await _localDs.clearAll();
  }
}
