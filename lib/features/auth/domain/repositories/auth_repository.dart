import '../entities/user.dart';

abstract class AuthRepository {
  /// Returns a fully-populated User or throws on error
  Future<User> login(String email, String password);
}
