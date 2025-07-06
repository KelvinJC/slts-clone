import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/core/api/network_exceptions.dart';
import 'package:slts_enforcer_app/core/services/biometric_service.dart';
import 'package:slts_enforcer_app/features/sync/data/repositories_impl/sync_repository_impl.dart';
import 'package:slts_enforcer_app/features/sync/domain/repositories/sync_repository.dart';
import 'package:slts_enforcer_app/features/violation/data/repositories/violation_repository_impl.dart';
import 'package:slts_enforcer_app/features/violation/domain/repositories/violation_repository.dart';
import 'core/api/app_api.dart';
import 'core/local_storage/local_storage.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'package:slts_enforcer_app/core/api/env.dart';

// /// 1) Core providers
// final dioProvider = Provider<Dio>((_) => throw UnimplementedError());
// final apiProvider = Provider<AppApi>((_) => throw UnimplementedError());
// final localStorageProvider = Provider<LocalStorage>(
//   (_) => throw UnimplementedError(),
// );

// /// 2) Feature providers
// final authRepositoryProvider = Provider<AuthRepository>(
//   (_) => throw UnimplementedError(),
// );

/// 1) Dio client with interceptor that embeds Failure into DioException.error

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Env.apiBase));

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException err, ErrorInterceptorHandler handler) {
        // Map to our Failure
        final failure = FailureFromDio.fromDio(err);
        // Throw a new DioException that **always** carries that failure
        handler.reject(
          DioException(requestOptions: err.requestOptions, error: failure),
        );
      },
    ),
  );

  return dio;
});

/// 2) Retrofit API on top of Dio
final apiProvider = Provider<AppApi>((ref) {
  return AppApi(ref.watch(dioProvider));
});

/// 3) Secure/local storage singleton
final localStorageProvider = Provider<LocalStorage>((_) {
  return LocalStorage.instance;
});

/// 4) AuthRepository wired with the API & storage
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    api: ref.watch(apiProvider),
    storage: ref.watch(localStorageProvider),
  );
});

/// 5) ViolationRepository wired with the API
final violationRepositoryProvider = Provider<ViolationRepository>(
  (ref) => ViolationRepositoryImpl(ref.read(apiProvider)),
);

/// 6) SyncRepository wired with the API & storage
final syncRepositoryProvider = Provider<SyncRepository>(
  (ref) =>
      SyncRepositoryImpl(ref.read(apiProvider), ref.read(localStorageProvider)),
);

final biometricProvider = Provider<BiometricService>(
  (ref) => BiometricService(),
);

class AppModule {
  // static List<Override> get overrides => [
  //   dioProvider.overrideWithValue(_createDio()),
  //   apiProvider.overrideWithValue(AppApi(_createDio())),
  //   localStorageProvider.overrideWithValue(LocalStorage.instance),
  //   authRepositoryProvider.overrideWithValue(
  //     AuthRepositoryImpl(
  //       api: AppApi(_createDio()),
  //       storage: LocalStorage.instance,
  //     ),
  //   ),
  // ];
  static List<Override> get overrides => [];

  // static Dio _createDio() {
  //   // final dio = Dio(BaseOptions(baseUrl: 'https://api.slts.example.com'));
  //   // dio.interceptors.add(LogInterceptor(responseBody: true));
  //   // return dio;

  //   final dio = Dio(BaseOptions(baseUrl: Env.apiBase))
  //     ..interceptors.add(
  //       InterceptorsWrapper(
  //         onError: (err, handler) {
  //           // Map to our Failure and rethrow as DioError with Failure inside
  //           final failure = mapDioError(err);
  //           handler.reject(
  //             DioException(requestOptions: err.requestOptions, error: failure),
  //           );
  //         },
  //       ),
  //     );
  //   return dio;
  // }
}
