import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request.dart';
// import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppApi api;
  final LocalStorage storage;

  AuthRepositoryImpl({required this.api, required this.storage});

  @override
  Future<User> login(String email, String password) async {
    final req = LoginRequest(email: email, password: password);
    final userModel = await api.login(req);
    // persist token
    await storage.write('auth_token', userModel.token);
    return userModel.toEntity();
  }
}
