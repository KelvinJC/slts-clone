import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
// import 'package:json_annotation/json_annotation.dart';
import '../../features/auth/data/models/login_request.dart';
import '../../features/auth/data/models/user_model.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST('/auth/login')
  Future<UserModel> login(@Body() LoginRequest body);

  @POST('/violations')
  Future<void> createViolation(@Body() CreateViolationRequest req); // ← new endpoint
}
