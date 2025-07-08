import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/features/auth/data/models/forgot_password_request.dart';
import 'package:slts_enforcer_app/features/auth/data/models/generic_response.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_request.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_response.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/data/models/run_plate_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/run_plate_response.dart';
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

  @POST('/password/forgot')
  Future<GenericResponse> requestPasswordReset(
    @Body() ForgotPasswordRequest body,
  );

  @POST('/violation/run-plate-number')
  Future<RunPlateResponse> runPlateNumber(@Body() RunPlateRequest body);

  @POST('/violations')
  Future<void> createViolation(@Body() CreateViolationRequest req);
}
