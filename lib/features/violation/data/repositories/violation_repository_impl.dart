import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
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
}
