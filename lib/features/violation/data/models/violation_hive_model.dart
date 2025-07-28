import 'package:hive/hive.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/create_violation.dart';

part 'violation_hive_model.g.dart';

@HiveType(typeId: 10)
class ViolationHiveModel {
  @HiveField(0)
  final int zoneId;
  @HiveField(1)
  final int commandId;
  @HiveField(2)
  final int offenceId;
  @HiveField(3)
  final String firstName;
  @HiveField(4)
  final String surname;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final String emailAddress;
  @HiveField(7)
  final int plateColorId;
  @HiveField(8)
  final int plateTypeId;
  @HiveField(9)
  final int eventTypeId;
  @HiveField(10)
  final int vehicleBrandId;
  @HiveField(11)
  final int vehicleColorId;
  @HiveField(12)
  final int vehicleTypeId;
  @HiveField(13)
  final String pcn;
  @HiveField(14)
  final String plateNo;
  @HiveField(15)
  final String violationDate;
  @HiveField(16)
  final String paymentAmount;
  @HiveField(17)
  final String sltsAmount;
  @HiveField(18)
  final String clientAmount;
  @HiveField(19)
  final String insertedBy;
  @HiveField(20)
  final List<String>? violationFiles;

  ViolationHiveModel({
    required this.zoneId,
    required this.commandId,
    required this.offenceId,
    required this.firstName,
    required this.surname,
    required this.phoneNumber,
    required this.emailAddress,
    required this.plateColorId,
    required this.plateTypeId,
    required this.eventTypeId,
    required this.vehicleBrandId,
    required this.vehicleColorId,
    required this.vehicleTypeId,
    required this.pcn,
    required this.plateNo,
    required this.violationDate,
    required this.paymentAmount,
    required this.sltsAmount,
    required this.clientAmount,
    required this.insertedBy,
    required this.violationFiles,
  });

  /// From domain → Hive
  factory ViolationHiveModel.fromDomain(CreateViolation v) =>
      ViolationHiveModel(
        zoneId: v.zoneId,
        commandId: v.commandId,
        offenceId: v.offenceId,
        firstName: v.firstName,
        surname: v.surname,
        phoneNumber: v.phoneNumber,
        emailAddress: v.emailAddress,
        plateColorId: v.plateColorId,
        plateTypeId: v.plateTypeId,
        eventTypeId: v.eventTypeId,
        vehicleBrandId: v.vehicleBrandId,
        vehicleColorId: v.vehicleColorId,
        vehicleTypeId: v.vehicleTypeId,
        pcn: v.pcn,
        plateNo: v.plateNo,
        violationDate: v.violationDate.toIso8601String(),
        paymentAmount: v.paymentAmount.toString(),
        sltsAmount: v.sltsAmount.toString(),
        clientAmount: v.clientAmount.toString(),
        insertedBy: v.insertedBy,
        violationFiles: v.violationFiles,
      );

  /// From Hive → domain
  CreateViolation toDomain() => CreateViolation(
    zoneId: zoneId,
    commandId: commandId,
    offenceId: offenceId,
    firstName: firstName,
    surname: surname,
    phoneNumber: phoneNumber,
    emailAddress: emailAddress,
    plateColorId: plateColorId,
    plateTypeId: plateTypeId,
    eventTypeId: eventTypeId,
    vehicleBrandId: vehicleBrandId,
    vehicleColorId: vehicleColorId,
    vehicleTypeId: vehicleTypeId,
    pcn: pcn,
    plateNo: plateNo,
    violationDate: DateTime.parse(violationDate),
    paymentAmount: int.parse(paymentAmount),
    sltsAmount: int.parse(sltsAmount),
    clientAmount: int.parse(clientAmount),
    insertedBy: insertedBy,
    violationFiles: violationFiles,
  );
}
