import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

// / StateNotifier that holds the AsyncValue<User>
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier(this._repo) : super(AsyncValue.data(null));
  final AuthRepository _repo;

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repo.login(email, password));
  }
}

/// Expose AuthNotifier to the UI
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
      (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
    );
