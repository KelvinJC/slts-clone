import 'package:connectivity_plus/connectivity_plus.dart';
import '../errors/failures.dart';

/// Throws NetworkFailure if no connection.
Future<void> ensureConnected({Duration timeout = const Duration(seconds: 1)}) {
  return Connectivity()
      .checkConnectivity()
      .timeout(timeout, onTimeout: () => throw NetworkFailure())
      .then((result) {
        if (result.contains(ConnectivityResult.none)) {
          throw NetworkFailure();
        }
      });
}
