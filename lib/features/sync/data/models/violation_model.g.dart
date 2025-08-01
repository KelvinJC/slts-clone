// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViolationModelAdapter extends TypeAdapter<ViolationModel> {
  @override
  final int typeId = 1;

  @override
  ViolationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViolationModel(
      id: fields[0] as int,
      zoneId: fields[1] as int,
      commandId: fields[2] as int,
      offenceId: fields[3] as int,
      offenderId: fields[4] as int,
      plateColorId: fields[5] as int,
      plateTypeId: fields[6] as int,
      eventTypeId: fields[7] as int,
      vehicleBrandId: fields[8] as int,
      vehicleColorId: fields[9] as int,
      vehicleTypeId: fields[10] as int,
      pcnNumber: fields[11] as String,
      plateNumber: fields[12] as String,
      violationDateIso: fields[13] as String,
      status: fields[14] as String,
      paymentMethod: fields[15] as String?,
      paymentPlatform: fields[16] as String?,
      paymentAmount: fields[17] as int,
      paymentDateIso: fields[18] as String?,
      sltsAmount: fields[19] as int,
      clientAmount: fields[20] as int,
      paymentStatus: fields[21] as String,
      paymentReference: fields[22] as String?,
      insertedBy: fields[23] as int,
      insertedDateIso: fields[24] as String,
      insertedByName: fields[25] as String,
      zoneName: fields[26] as String,
      commandName: fields[27] as String,
      offenceName: fields[28] as String,
      offenceCode: fields[29] as String,
      offenceShort: fields[30] as String,
      amount: fields[31] as int,
      firstName: fields[32] as String,
      surname: fields[33] as String,
      offenderName: fields[34] as String,
      phoneNumber: fields[35] as String,
      emailAddress: fields[36] as String,
      plateColorName: fields[37] as String,
      plateTypeName: fields[38] as String,
      eventTypeName: fields[39] as String,
      vehicleBrandName: fields[40] as String,
      vehicleColorName: fields[41] as String,
      vehicleTypeName: fields[42] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ViolationModel obj) {
    writer
      ..writeByte(43)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.zoneId)
      ..writeByte(2)
      ..write(obj.commandId)
      ..writeByte(3)
      ..write(obj.offenceId)
      ..writeByte(4)
      ..write(obj.offenderId)
      ..writeByte(5)
      ..write(obj.plateColorId)
      ..writeByte(6)
      ..write(obj.plateTypeId)
      ..writeByte(7)
      ..write(obj.eventTypeId)
      ..writeByte(8)
      ..write(obj.vehicleBrandId)
      ..writeByte(9)
      ..write(obj.vehicleColorId)
      ..writeByte(10)
      ..write(obj.vehicleTypeId)
      ..writeByte(11)
      ..write(obj.pcnNumber)
      ..writeByte(12)
      ..write(obj.plateNumber)
      ..writeByte(13)
      ..write(obj.violationDateIso)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.paymentMethod)
      ..writeByte(16)
      ..write(obj.paymentPlatform)
      ..writeByte(17)
      ..write(obj.paymentAmount)
      ..writeByte(18)
      ..write(obj.paymentDateIso)
      ..writeByte(19)
      ..write(obj.sltsAmount)
      ..writeByte(20)
      ..write(obj.clientAmount)
      ..writeByte(21)
      ..write(obj.paymentStatus)
      ..writeByte(22)
      ..write(obj.paymentReference)
      ..writeByte(23)
      ..write(obj.insertedBy)
      ..writeByte(24)
      ..write(obj.insertedDateIso)
      ..writeByte(25)
      ..write(obj.insertedByName)
      ..writeByte(26)
      ..write(obj.zoneName)
      ..writeByte(27)
      ..write(obj.commandName)
      ..writeByte(28)
      ..write(obj.offenceName)
      ..writeByte(29)
      ..write(obj.offenceCode)
      ..writeByte(30)
      ..write(obj.offenceShort)
      ..writeByte(31)
      ..write(obj.amount)
      ..writeByte(32)
      ..write(obj.firstName)
      ..writeByte(33)
      ..write(obj.surname)
      ..writeByte(34)
      ..write(obj.offenderName)
      ..writeByte(35)
      ..write(obj.phoneNumber)
      ..writeByte(36)
      ..write(obj.emailAddress)
      ..writeByte(37)
      ..write(obj.plateColorName)
      ..writeByte(38)
      ..write(obj.plateTypeName)
      ..writeByte(39)
      ..write(obj.eventTypeName)
      ..writeByte(40)
      ..write(obj.vehicleBrandName)
      ..writeByte(41)
      ..write(obj.vehicleColorName)
      ..writeByte(42)
      ..write(obj.vehicleTypeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViolationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationModel _$ViolationModelFromJson(Map<String, dynamic> json) =>
    ViolationModel(
      id: (json['violation_id'] as num).toInt(),
      zoneId: (json['zone_id'] as num).toInt(),
      commandId: (json['command_id'] as num).toInt(),
      offenceId: (json['offence_id'] as num).toInt(),
      offenderId: (json['offender_id'] as num).toInt(),
      plateColorId: (json['plate_color_id'] as num).toInt(),
      plateTypeId: (json['plate_type_id'] as num).toInt(),
      eventTypeId: (json['event_type_id'] as num).toInt(),
      vehicleBrandId: (json['vehicle_brand_id'] as num).toInt(),
      vehicleColorId: (json['vehicle_color_id'] as num).toInt(),
      vehicleTypeId: (json['vehicle_type_id'] as num).toInt(),
      pcnNumber: json['pcn'] as String,
      plateNumber: json['plate_no'] as String,
      violationDateIso: json['violation_date'] as String,
      status: json['status'] as String,
      paymentMethod: json['payment_method'] as String?,
      paymentPlatform: json['payment_platform'] as String?,
      paymentAmount: (json['payment_amount'] as num).toInt(),
      paymentDateIso: json['payment_date'] as String?,
      sltsAmount: (json['slts_amount'] as num).toInt(),
      clientAmount: (json['client_amount'] as num).toInt(),
      paymentStatus: json['payment_status'] as String,
      paymentReference: json['payment_reference'] as String?,
      insertedBy: (json['inserted_by'] as num).toInt(),
      insertedDateIso: json['inserted_date'] as String,
      insertedByName: json['inserted_by_name'] as String,
      zoneName: json['zone_name'] as String,
      commandName: json['command_name'] as String,
      offenceName: json['offence_name'] as String,
      offenceCode: json['offence_code'] as String,
      offenceShort: json['offence_short'] as String,
      amount: (json['amount'] as num).toInt(),
      firstName: json['first_name'] as String,
      surname: json['surname'] as String,
      offenderName: json['offender_name'] as String,
      phoneNumber: json['phone_number'] as String,
      emailAddress: json['email_address'] as String,
      plateColorName: json['plate_color_name'] as String,
      plateTypeName: json['plate_type_name'] as String,
      eventTypeName: json['event_type_name'] as String,
      vehicleBrandName: json['vehicle_brand_name'] as String,
      vehicleColorName: json['vehicle_color_name'] as String,
      vehicleTypeName: json['vehicle_type_name'] as String,
    );

Map<String, dynamic> _$ViolationModelToJson(ViolationModel instance) =>
    <String, dynamic>{
      'violation_id': instance.id,
      'zone_id': instance.zoneId,
      'command_id': instance.commandId,
      'offence_id': instance.offenceId,
      'offender_id': instance.offenderId,
      'plate_color_id': instance.plateColorId,
      'plate_type_id': instance.plateTypeId,
      'event_type_id': instance.eventTypeId,
      'vehicle_brand_id': instance.vehicleBrandId,
      'vehicle_color_id': instance.vehicleColorId,
      'vehicle_type_id': instance.vehicleTypeId,
      'pcn': instance.pcnNumber,
      'plate_no': instance.plateNumber,
      'violation_date': instance.violationDateIso,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'payment_platform': instance.paymentPlatform,
      'payment_amount': instance.paymentAmount,
      'payment_date': instance.paymentDateIso,
      'slts_amount': instance.sltsAmount,
      'client_amount': instance.clientAmount,
      'payment_status': instance.paymentStatus,
      'payment_reference': instance.paymentReference,
      'inserted_by': instance.insertedBy,
      'inserted_date': instance.insertedDateIso,
      'inserted_by_name': instance.insertedByName,
      'zone_name': instance.zoneName,
      'command_name': instance.commandName,
      'offence_name': instance.offenceName,
      'offence_code': instance.offenceCode,
      'offence_short': instance.offenceShort,
      'amount': instance.amount,
      'first_name': instance.firstName,
      'surname': instance.surname,
      'offender_name': instance.offenderName,
      'phone_number': instance.phoneNumber,
      'email_address': instance.emailAddress,
      'plate_color_name': instance.plateColorName,
      'plate_type_name': instance.plateTypeName,
      'event_type_name': instance.eventTypeName,
      'vehicle_brand_name': instance.vehicleBrandName,
      'vehicle_color_name': instance.vehicleColorName,
      'vehicle_type_name': instance.vehicleTypeName,
    };
