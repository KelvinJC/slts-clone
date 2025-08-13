// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponse _$VerifyOtpResponseFromJson(Map<String, dynamic> json) =>
    VerifyOtpResponse(
      message: json['message'] as String?,
      userData: (json['userData'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VerifyOtpResponseToJson(VerifyOtpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userData': instance.userData,
    };
