import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';

/// A singleton wrapper around FlutterSecureStorage.
/// Use this for persisting sensitive data (tokens, configs).
class LocalStorage {
  LocalStorage._();

  /// The single instance exposed app‑wide.
  static final LocalStorage instance = LocalStorage._();

  /// Underlying secure storage.
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  /// Run any async initialization here.
  Future<void> init() async {
    // SecureStorage init (no-op today)
    // Now also initialize Hive:
    await Hive.initFlutter();
    // Register adapters:
    Hive.registerAdapter(ViolationModelAdapter());
  }

  /// Write a string [value] under [key].
  Future<void> write(String key, String value) =>
      _secure.write(key: key, value: value);

  /// Read the string stored under [key], or null if missing.
  Future<String?> read(String key) => _secure.read(key: key);

  /// Delete the entry under [key].
  Future<void> delete(String key) => _secure.delete(key: key);

  /// Convenience: persist your auth token.
  Future<void> saveAuthToken(String token) => write(_Keys.authToken, token);

  /// Convenience: read your auth token.
  Future<String?> getAuthToken() => read(_Keys.authToken);

  /// Convenience: clear your auth token (e.g. on logout).
  Future<void> clearAuthToken() => delete(_Keys.authToken);

  /// Convenience: persist your auth token.
  Future<void> saveUseBiometrics(bool useBiometrics) =>
      write(_Keys.authToken, useBiometrics.toString());

  /// Convenience: read your auth token.
  Future<bool> getUseBiometrics() async {
    final result = await read(_Keys.useBiometrics);
    if (result == null) return false;

    return Future.value(result.toString() == 'true');
  }
}

/// Private keys used in secure storage.
class _Keys {
  static const authToken = 'auth_token';
  static const useBiometrics = 'use_biometrics';
  // add more keys here as needed
}
