import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/features/auth/data/models/generic_response.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_request.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_response.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../features/auth/data/models/login_request.dart';
import '../../features/auth/data/models/user_model.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  /// Step 1: send credentials
  @POST('/login/authenticate')
  Future<GenericResponse> authenticate(@Body() LoginRequest body);

  /// Step 2: submit OTP
  @POST('/login/admin')
  Future<VerifyOtpResponse> verifyOtp(@Body() VerifyOtpRequest body);

  // @POST('/login')
  // Future<UserModel> login(@Body() LoginRequest body);

  @POST('/violations')
  Future<void> createViolation(@Body() CreateViolationRequest req);
}
