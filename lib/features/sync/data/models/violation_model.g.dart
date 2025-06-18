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
      id: fields[0] as String,
      plateNumber: fields[1] as String,
      offenceType: fields[2] as String,
      timestamp: fields[3] as DateTime,
      photoPath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ViolationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.plateNumber)
      ..writeByte(2)
      ..write(obj.offenceType)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.photoPath);
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
