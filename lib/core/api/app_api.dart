import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:slts_enforcer_app/features/auth/data/models/forgot_password_request.dart';
import 'package:slts_enforcer_app/features/auth/data/models/generic_response.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_request.dart';
import 'package:slts_enforcer_app/features/auth/data/models/verify_otp_response.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/data/models/list_item_model.dart';
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

  @PATCH('/login/forget_password/add_token')
  Future<GenericResponse> requestPasswordReset(
    @Body() ForgotPasswordRequest body,
  );

  @POST('/authenticate-with-token')
  Future<VerifyOtpResponse> loginWithToken();

  @POST('/violation/run-plate-number')
  Future<RunPlateResponse> runPlateNumber(@Body() RunPlateRequest body);

  @GET('/settings/vehicle/brand/list')
  Future<GenericResponse> getVehicleBrandList();

  @GET('/settings/vehicle/color/list')
  Future<GenericResponse> getVehicleColorList();

  @GET('/settings/vehicle/type/list')
  Future<GenericResponse> getVehicleTypeList();

  @GET('/settings/plate/type/list')
  Future<GenericResponse> getPlateTypeList();

  @GET('/settings/plate/color/list')
  Future<GenericResponse> getPlateColorList();

  @GET('/violation/offence/list')
  Future<GenericResponse> getOffenceList();

  @GET('/settings/event/type/list')
  Future<GenericResponse> getEventTypeList();

  @GET('/settings/zone/list')
  Future<GenericResponse> getZoneList();

  @GET('/settings/command/list/{zoneId}')
  Future<GenericResponse> getCommandList(@Path() int zoneId);

  @POST('/violation/add')
  Future<GenericResponse> createViolation(@Body() CreateViolationRequest req);
}
