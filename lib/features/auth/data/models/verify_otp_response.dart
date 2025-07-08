import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  final String message;
  @JsonKey(name: 'userData')
  final List<UserModel>? userData;

  VerifyOtpResponse({required this.message, required this.userData});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}
