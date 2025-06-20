import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/core/api/app_api.dart';
// import 'package:slts_enforcer_app/core/api/network_exceptions.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/core/utils/connectivity_helper.dart';
import 'package:slts_enforcer_app/core/utils/retry.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppApi api;
  final LocalStorage storage;

  AuthRepositoryImpl({required this.api, required this.storage});

  @override
  Future<User> login(String email, String password) async {
    try {
      // 1) Connectivity guard
      await ensureConnected();

      final req = LoginRequest(email: email, password: password);

      // 2) Retry the entire flow
      return await retry<User>(() async {
        final model = await api.login(req); // onError → failure
        await storage.saveAuthToken(model.token);
        return model.toEntity();
      });
    } on Failure catch (failure) {
      // This will catch:
      //  • NetworkFailure / ServerFailure from the interceptor
      //  • NetworkFailure from ensureConnected
      debugPrint('[AuthRepo] login failure: ${failure.displayMessage}');
      rethrow;
    } catch (e, st) {
      // Anything else
      debugPrint('[AuthRepo] unexpected: $e\n$st');
      throw UnexpectedFailure(rawMessage: e.toString());
    }
  }
}
