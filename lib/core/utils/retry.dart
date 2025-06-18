import 'package:dio/dio.dart';
import '../errors/failures.dart';
import '../api/network_exceptions.dart';

/// Only retry on timeouts or 5xx. Otherwise rethrow immediately.
Future<T> retry<T>(
  Future<T> Function() fn, {
  int attempts = 1,
  Duration delay = const Duration(seconds: 1),
}) async {
  Failure? lastFailure;

  for (var i = 0; i < attempts; i++) {
    try {
      return await fn();
    } on DioException catch (dioErr) {
      final failure = FailureFromDio.fromDio(dioErr);

      // If it’s not a timeout or server error, give up immediately:
      if (failure is! NetworkFailure ||
          (dioErr.type != DioExceptionType.connectionTimeout &&
                  dioErr.type != DioExceptionType.receiveTimeout) &&
              (failure is! ServerFailure ||
                  (failure.code! < 500 || failure.code! >= 600))) {
        throw failure;
      }

      // otherwise remember it and retry
      lastFailure = failure;
    } on Failure catch (f) {
      // e.g. connectivity guard—fail fast
      lastFailure = f;
      break;
    } catch (e) {
      lastFailure = UnexpectedFailure(rawMessage: e.toString());
      break;
    }

    // back‑off before next try
    await Future.delayed(delay * (i + 1));
  }

  throw lastFailure!;
}
