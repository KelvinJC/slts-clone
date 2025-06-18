import 'package:hive/hive.dart';

part 'violation_model.g.dart';

@HiveType(typeId: 0)
class ViolationModel extends HiveObject {
  @HiveField(0)
  final String id; // UUID
  @HiveField(1)
  final String plateNumber;
  @HiveField(2)
  final String offenceType;
  @HiveField(3)
  final DateTime timestamp;
  @HiveField(4)
  final String? photoPath; // local file URI
  // add other fields as needed

  ViolationModel({
    required this.id,
    required this.plateNumber,
    required this.offenceType,
    required this.timestamp,
    this.photoPath,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'plate': plateNumber,
    'offence': offenceType,
    'timestamp': timestamp.toIso8601String(),
    // photo upload will be handled separately
  };
}
