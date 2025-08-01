// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_capture_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdCaptureRequest _$IdCaptureRequestFromJson(Map<String, dynamic> json) =>
    IdCaptureRequest(
      driversLicense: json['drivers_license'] as bool,
      vehicleParticulars: json['vehicle_particulars'] as bool,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$IdCaptureRequestToJson(IdCaptureRequest instance) =>
    <String, dynamic>{
      'drivers_license': instance.driversLicense,
      'vehicle_particulars': instance.vehicleParticulars,
      'comment': instance.comment,
    };
