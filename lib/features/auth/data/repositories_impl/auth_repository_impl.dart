// import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/core/api/app_api.dart';
// import 'package:slts_enforcer_app/core/api/network_exceptions.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/core/utils/connectivity_helper.dart';
import 'package:slts_enforcer_app/core/utils/retry.dart';
import 'package:slts_enforcer_app/features/auth/data/models/forgot_password_request.dart';
// import 'package:slts_enforcer_app/core/utils/connectivity_helper.dart';
// import 'package:slts_enforcer_app/core/utils/retry.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppApi api;
  final LocalStorage storage;

  AuthRepositoryImpl({required this.api, required this.storage});

  @override
  Future<void> authenticate(String username, String password) async {
    // 1) ensure we have connectivity
    await ensureConnected();

    // 2) build request once
    final req = LoginRequest(username: username, password: password);

    // 3) retry the whole call on transient errors
    await retry<void>(() async {
      final resp = await api.authenticate(req);
      if (resp.message?.toLowerCase() != 'success') {
        throw UnexpectedFailure(
          rawMessage: 'Authentication failed: ${resp.message}',
        );
      }
    });
  }

  @override
  Future<User> verifyOtp(String otp, String email) async {
    await ensureConnected();
    final req = VerifyOtpRequest(otpToken: otp, emailAddress: email);

    return await retry<User>(() async {
      final resp = await api.verifyOtp(req);
      if (resp.message?.toLowerCase() != 'success' ||
          (resp.userData?.isEmpty ?? true)) {
        throw UnexpectedFailure(rawMessage: 'OTP verification failed');
      }

      final userModel = resp.userData?.first;
      // persist the token
      await storage.saveAuthToken(
        userModel!.token.headers['SLTSTrafficAPIToken']!,
      );

      // persist useBiometric
      await storage.saveUseBiometrics(true);

      return userModel.toEntity();
    });
  }

  @override
  Future<User> loginWithToken() async {
    await ensureConnected();
    return await retry<User>(() async {
      final resp = await api.loginWithToken();
      if (resp.message?.toLowerCase() != 'success' ||
          (resp.userData?.isEmpty ?? true)) {
        throw UnexpectedFailure(rawMessage: 'Login failed');
      }

      final userModel = resp.userData?.first;
      // persist the token
      await storage.saveAuthToken(
        userModel!.token.headers['SLTSTrafficAPIToken']!,
      );

      // persist useBiometric
      await storage.saveUseBiometrics(true);

      return userModel.toEntity();
    });
  }

  @override
  Future<void> forgotPassword(String email, String token) async {
    await ensureConnected();
    final req = ForgotPasswordRequest(email: email, token: token);

    return await retry<void>(() async {
      final response = await api.requestPasswordReset(req);
      if (response.message?.toLowerCase() != 'success') {
        throw UnexpectedFailure(rawMessage: response.message);
      }
    });
  }

  // @override
  // Future<User> login(String email, String password) async {
  //   try {
  //     // 1) Connectivity guard
  //     await ensureConnected();

  //     final req = LoginRequest(email: email, password: password);

  //     // 2) Retry the entire flow
  //     return await retry<User>(() async {
  //       final model = await api.login(req); // onError → failure
  //       await storage.saveAuthToken(model.token);
  //       return model.toEntity();
  //     });
  //   } on Failure catch (failure) {
  //     // This will catch:
  //     //  • NetworkFailure / ServerFailure from the interceptor
  //     //  • NetworkFailure from ensureConnected
  //     debugPrint('[AuthRepo] login failure: ${failure.displayMessage}');
  //     rethrow;
  //   } catch (e, st) {
  //     // Anything else
  //     debugPrint('[AuthRepo] unexpected: $e\n$st');
  //     throw UnexpectedFailure(rawMessage: e.toString());
  //   }
  // }
}
