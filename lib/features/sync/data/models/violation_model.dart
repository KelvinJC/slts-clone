import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'violation_model.g.dart';

@HiveType(typeId: 0) // assign a unique typeId per model
class ViolationModel extends Equatable {
  @HiveField(0)
  final String offence;

  @HiveField(1)
  final String eventType;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String zone;

  @HiveField(4)
  final String command;

  @HiveField(5)
  final String firstName;

  @HiveField(6)
  final String surname;

  @HiveField(7)
  final String phone;

  @HiveField(8)
  final String plate;

  @HiveField(9)
  final String plateType;

  @HiveField(10)
  final String plateColor;

  @HiveField(11)
  final String brand;

  @HiveField(12)
  final String vehicleType;

  @HiveField(13)
  final String vehicleColor;

  @HiveField(14)
  final List<String> mediaPaths;

  const ViolationModel({
    required this.offence,
    required this.eventType,
    required this.date,
    required this.zone,
    required this.command,
    required this.firstName,
    required this.surname,
    required this.phone,
    required this.plate,
    required this.plateType,
    required this.plateColor,
    required this.brand,
    required this.vehicleType,
    required this.vehicleColor,
    this.mediaPaths = const [],
  });

  @override
  List<Object?> get props => [
    offence,
    eventType,
    date,
    zone,
    command,
    firstName,
    surname,
    phone,
    plate,
    plateType,
    plateColor,
    brand,
    vehicleType,
    vehicleColor,
    mediaPaths,
  ];
}
