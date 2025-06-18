import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'core/api/app_api.dart';
import 'core/local_storage/local_storage.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

/// 1) Core providers
final dioProvider = Provider<Dio>((_) => throw UnimplementedError());
final apiProvider = Provider<AppApi>((_) => throw UnimplementedError());
final localStorageProvider = Provider<LocalStorage>(
  (_) => throw UnimplementedError(),
);

/// 2) Feature providers
final authRepositoryProvider = Provider<AuthRepository>(
  (_) => throw UnimplementedError(),
);

class AppModule {
  static List<Override> get overrides => [
    dioProvider.overrideWithValue(_createDio()),
    apiProvider.overrideWithValue(AppApi(_createDio())),
    localStorageProvider.overrideWithValue(LocalStorage.instance),
    authRepositoryProvider.overrideWithValue(
      AuthRepositoryImpl(
        api: AppApi(_createDio()),
        storage: LocalStorage.instance,
      ),
    ),
  ];

  static Dio _createDio() {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.slts.example.com'));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
