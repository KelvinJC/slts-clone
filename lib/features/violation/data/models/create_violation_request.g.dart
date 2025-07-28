// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_violation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateViolationRequest _$CreateViolationRequestFromJson(
        Map<String, dynamic> json) =>
    CreateViolationRequest(
      zoneId: json['zone_id'] as String,
      commandId: json['command_id'] as String,
      offenceId: json['offence_id'] as String,
      firstName: json['first_name'] as String,
      surname: json['surname'] as String,
      phoneNumber: json['phone_number'] as String,
      emailAddress: json['email_address'] as String,
      plateColorId: json['plate_color_id'] as String,
      plateTypeId: json['plate_type_id'] as String,
      eventTypeId: json['event_type_id'] as String,
      vehicleBrandId: json['vehicle_brand_id'] as String,
      vehicleColorId: json['vehicle_color_id'] as String,
      vehicleTypeId: json['vehicle_type_id'] as String,
      pcn: json['pcn'] as String,
      plateNo: json['plate_no'] as String,
      violationDate: json['violation_date'] as String,
      paymentAmount: json['payment_amount'] as String,
      sltsAmount: json['slts_amount'] as String,
      clientAmount: json['client_amount'] as String,
      insertedBy: json['inserted_by'] as String,
      violationFiles: (json['violation_files'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateViolationRequestToJson(
        CreateViolationRequest instance) =>
    <String, dynamic>{
      'zone_id': instance.zoneId,
      'command_id': instance.commandId,
      'offence_id': instance.offenceId,
      'first_name': instance.firstName,
      'surname': instance.surname,
      'phone_number': instance.phoneNumber,
      'email_address': instance.emailAddress,
      'plate_color_id': instance.plateColorId,
      'plate_type_id': instance.plateTypeId,
      'event_type_id': instance.eventTypeId,
      'vehicle_brand_id': instance.vehicleBrandId,
      'vehicle_color_id': instance.vehicleColorId,
      'vehicle_type_id': instance.vehicleTypeId,
      'pcn': instance.pcn,
      'plate_no': instance.plateNo,
      'violation_date': instance.violationDate,
      'payment_amount': instance.paymentAmount,
      'slts_amount': instance.sltsAmount,
      'client_amount': instance.clientAmount,
      'inserted_by': instance.insertedBy,
      'violation_files': instance.violationFiles,
    };
