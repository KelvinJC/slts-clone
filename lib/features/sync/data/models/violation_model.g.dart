// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViolationModelAdapter extends TypeAdapter<ViolationModel> {
  @override
  final int typeId = 0;

  @override
  ViolationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViolationModel(
      offence: fields[0] as String,
      eventType: fields[1] as String,
      date: fields[2] as String,
      zone: fields[3] as String,
      command: fields[4] as String,
      firstName: fields[5] as String,
      surname: fields[6] as String,
      phone: fields[7] as String,
      plate: fields[8] as String,
      plateType: fields[9] as String,
      plateColor: fields[10] as String,
      brand: fields[11] as String,
      vehicleType: fields[12] as String,
      vehicleColor: fields[13] as String,
      mediaPaths: (fields[14] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ViolationModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.offence)
      ..writeByte(1)
      ..write(obj.eventType)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.zone)
      ..writeByte(4)
      ..write(obj.command)
      ..writeByte(5)
      ..write(obj.firstName)
      ..writeByte(6)
      ..write(obj.surname)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.plate)
      ..writeByte(9)
      ..write(obj.plateType)
      ..writeByte(10)
      ..write(obj.plateColor)
      ..writeByte(11)
      ..write(obj.brand)
      ..writeByte(12)
      ..write(obj.vehicleType)
      ..writeByte(13)
      ..write(obj.vehicleColor)
      ..writeByte(14)
      ..write(obj.mediaPaths);
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
