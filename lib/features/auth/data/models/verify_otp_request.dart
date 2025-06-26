import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  @JsonKey(name: 'otp_token')
  final String otpToken;

  @JsonKey(name: 'email_address')
  final String emailAddress;

  VerifyOtpRequest({required this.otpToken, required this.emailAddress});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
