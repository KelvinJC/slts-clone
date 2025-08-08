// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionRequest _$ActionRequestFromJson(Map<String, dynamic> json) =>
    ActionRequest(
      pcn: (json['pcn'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as String,
      status: json['status'] as String? ?? 'successful',
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ActionRequestToJson(ActionRequest instance) =>
    <String, dynamic>{
      'pcn': instance.pcn,
      'type': instance.type,
      'status': instance.status,
      'comment': instance.comment,
    };
