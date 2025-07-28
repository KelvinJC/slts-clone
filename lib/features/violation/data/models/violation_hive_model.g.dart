// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViolationHiveModelAdapter extends TypeAdapter<ViolationHiveModel> {
  @override
  final int typeId = 10;

  @override
  ViolationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViolationHiveModel(
      zoneId: fields[0] as int,
      commandId: fields[1] as int,
      offenceId: fields[2] as int,
      firstName: fields[3] as String,
      surname: fields[4] as String,
      phoneNumber: fields[5] as String,
      emailAddress: fields[6] as String,
      plateColorId: fields[7] as int,
      plateTypeId: fields[8] as int,
      eventTypeId: fields[9] as int,
      vehicleBrandId: fields[10] as int,
      vehicleColorId: fields[11] as int,
      vehicleTypeId: fields[12] as int,
      pcn: fields[13] as String,
      plateNo: fields[14] as String,
      violationDate: fields[15] as String,
      paymentAmount: fields[16] as String,
      sltsAmount: fields[17] as String,
      clientAmount: fields[18] as String,
      insertedBy: fields[19] as String,
      violationFiles: (fields[20] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ViolationHiveModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.zoneId)
      ..writeByte(1)
      ..write(obj.commandId)
      ..writeByte(2)
      ..write(obj.offenceId)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.surname)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.emailAddress)
      ..writeByte(7)
      ..write(obj.plateColorId)
      ..writeByte(8)
      ..write(obj.plateTypeId)
      ..writeByte(9)
      ..write(obj.eventTypeId)
      ..writeByte(10)
      ..write(obj.vehicleBrandId)
      ..writeByte(11)
      ..write(obj.vehicleColorId)
      ..writeByte(12)
      ..write(obj.vehicleTypeId)
      ..writeByte(13)
      ..write(obj.pcn)
      ..writeByte(14)
      ..write(obj.plateNo)
      ..writeByte(15)
      ..write(obj.violationDate)
      ..writeByte(16)
      ..write(obj.paymentAmount)
      ..writeByte(17)
      ..write(obj.sltsAmount)
      ..writeByte(18)
      ..write(obj.clientAmount)
      ..writeByte(19)
      ..write(obj.insertedBy)
      ..writeByte(20)
      ..write(obj.violationFiles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViolationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
