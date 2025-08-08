// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_link_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendLinkRequest _$ResendLinkRequestFromJson(Map<String, dynamic> json) =>
    ResendLinkRequest(
      pcn: json['pcn'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResendLinkRequestToJson(ResendLinkRequest instance) =>
    <String, dynamic>{
      'pcn': instance.pcn,
      'email': instance.email,
    };
