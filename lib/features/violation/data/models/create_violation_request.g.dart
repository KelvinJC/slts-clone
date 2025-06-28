// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_violation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateViolationRequest _$CreateViolationRequestFromJson(
        Map<String, dynamic> json) =>
    CreateViolationRequest(
      offence: json['offence'] as String,
      eventType: json['eventType'] as String,
      date: json['date'] as String,
      zone: json['zone'] as String,
      command: json['command'] as String,
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
      phone: json['phone'] as String,
      plate: json['plate'] as String,
      plateType: json['plateType'] as String,
      plateColor: json['plateColor'] as String,
      brand: json['brand'] as String,
      vehicleType: json['vehicleType'] as String,
      vehicleColor: json['vehicleColor'] as String,
      mediaPaths: (json['mediaPaths'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateViolationRequestToJson(
        CreateViolationRequest instance) =>
    <String, dynamic>{
      'offence': instance.offence,
      'eventType': instance.eventType,
      'date': instance.date,
      'zone': instance.zone,
      'command': instance.command,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'phone': instance.phone,
      'plate': instance.plate,
      'plateType': instance.plateType,
      'plateColor': instance.plateColor,
      'brand': instance.brand,
      'vehicleType': instance.vehicleType,
      'vehicleColor': instance.vehicleColor,
      'mediaPaths': instance.mediaPaths,
    };
