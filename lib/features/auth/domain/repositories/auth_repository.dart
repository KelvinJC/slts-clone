import '../entities/user.dart';

abstract class AuthRepository {
  // /// Returns a fully-populated User or throws on error
  // Future<User> login(String email, String password);

  /// Step 1: Authenticate with email & password.
  ///
  /// Throws a [Failure] if authentication fails (i.e. response.message != "success").
  Future<void> authenticate(String email, String password);

  /// Step 2: Verify the email OTP and return the authenticated [User].
  ///
  /// Throws a [Failure] if OTP verification fails or no userData is returned.
  Future<User> verifyOtp(String otp, String email);
}
