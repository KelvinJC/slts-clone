// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_violation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateViolationRequest _$CreateViolationRequestFromJson(
        Map<String, dynamic> json) =>
    CreateViolationRequest(
      id: json['id'] as String,
      plateNumber: json['plate'] as String,
      offenceType: json['offence'] as String,
      timestamp: json['timestamp'] as String,
      photoPath: json['photoPath'] as String?,
    );

Map<String, dynamic> _$CreateViolationRequestToJson(
        CreateViolationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plate': instance.plateNumber,
      'offence': instance.offenceType,
      'timestamp': instance.timestamp,
      'photoPath': instance.photoPath,
    };
