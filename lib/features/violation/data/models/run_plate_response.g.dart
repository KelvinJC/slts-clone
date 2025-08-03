// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_plate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunPlateResponse _$RunPlateResponseFromJson(Map<String, dynamic> json) =>
    RunPlateResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ViolationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RunPlateResponseToJson(RunPlateResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
