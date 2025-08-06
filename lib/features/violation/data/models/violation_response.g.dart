// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationResponse _$ViolationResponseFromJson(Map<String, dynamic> json) =>
    ViolationResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ViolationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => ViolationFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViolationResponseToJson(ViolationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'pagination': instance.pagination,
      'files': instance.files,
    };
