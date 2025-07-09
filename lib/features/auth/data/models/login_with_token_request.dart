import 'package:json_annotation/json_annotation.dart';

part 'login_with_token_request.g.dart';

@JsonSerializable()
class LoginWithTokenRequest {
  @JsonKey(name: 'token')
  final String token;

  LoginWithTokenRequest({required this.token});

  factory LoginWithTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginWithTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginWithTokenRequestToJson(this);
}
