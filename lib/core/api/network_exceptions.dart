import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/failures.dart';

extension FailureFromDio on Failure {
  /// Create the appropriate Failure subclass
  static Failure fromDio(DioException err) {
    // 1) If we already stored a Failure, return it
    if (err.error is Failure) return err.error as Failure;

    // 2) Socket issues → NetworkFailure
    if (err.error is SocketException ||
        err.type == DioExceptionType.connectionError) {
      return NetworkFailure(rawMessage: err.message, code: err.type.index);
    }

    // 3) Timeouts → NetworkFailure
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure(
        rawMessage: 'Connection timed out.',
        code: err.type.index,
      );
    }

    // 4) HTTP status → ServerFailure
    if (err.type == DioExceptionType.badResponse) {
      final sc = err.response?.statusCode ?? -1;
      return ServerFailure(
        statusCode: sc,
        rawMessage: err.response?.statusMessage,
      );
    }

    // 5) Fallback
    return UnexpectedFailure(rawMessage: err.message);
  }
}
