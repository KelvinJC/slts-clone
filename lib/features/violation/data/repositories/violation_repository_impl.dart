import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/core/utils/connectivity_helper.dart';
import 'package:slts_enforcer_app/core/utils/retry.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/run_plate_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
// import 'package:slts_enforcer_app/core/errors/failures.dart';
import '../../domain/repositories/violation_repository.dart';

class ViolationRepositoryImpl implements ViolationRepository {
  final AppApi _api;
  ViolationRepositoryImpl(this._api);

  @override
  Future<void> createViolation(CreateViolationRequest req) async {
    try {
      await _api.createViolation(req);
    } catch (e) {
      // you can map DioExceptions to Failures here if needed
      rethrow;
    }
  }

  @override
  Future<List<Violation>> runPlateNumber(String plate) async {
    await ensureConnected();
    final request = RunPlateRequest(search: plate);

    return await retry<List<Violation>>(() async {
      final response = await _api.runPlateNumber(request);
      if (response.message.toLowerCase() != 'success') {
        throw UnexpectedFailure(rawMessage: response.message);
      }

      return response.data.map((m) => m.toEntity()).toList();
    });
  }
}
