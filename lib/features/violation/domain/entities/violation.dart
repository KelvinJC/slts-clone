import 'package:equatable/equatable.dart';

/// The domain‑level representation of a violation event.
class Violation extends Equatable {
  final int id;
  final int zoneId;
  final int commandId;
  final int offenceId;
  final int offenderId;
  final int plateColorId;
  final int plateTypeId;
  final int eventTypeId;
  final int vehicleBrandId;
  final int vehicleColorId;
  final int vehicleTypeId;
  final String pcnNumber;
  final String plateNumber;
  final DateTime violationDate;
  final String status;
  final String? paymentMethod;
  final String? paymentPlatform;
  final int paymentAmount;
  final DateTime? paymentDate;
  final int sltsAmount;
  final int clientAmount;
  final String paymentStatus;
  final String? paymentReference;
  final int insertedBy;
  final DateTime insertedDate;
  final String insertedByName;

  // human‑readable names
  final String zoneName;
  final String commandName;
  final String offenceName;
  final String offenceCode;
  final String offenceShort;
  final int amount; // looks like the total amount
  final String firstName;
  final String surname;
  final String offenderName;
  final String phoneNumber;
  final String emailAddress;
  final String plateColorName;
  final String plateTypeName;
  final String eventTypeName;
  final String vehicleBrandName;
  final String vehicleColorName;
  final String vehicleTypeName;

  const Violation({
    required this.id,
    required this.zoneId,
    required this.commandId,
    required this.offenceId,
    required this.offenderId,
    required this.plateColorId,
    required this.plateTypeId,
    required this.eventTypeId,
    required this.vehicleBrandId,
    required this.vehicleColorId,
    required this.vehicleTypeId,
    required this.pcnNumber,
    required this.plateNumber,
    required this.violationDate,
    required this.status,
    this.paymentMethod,
    this.paymentPlatform,
    required this.paymentAmount,
    this.paymentDate,
    required this.sltsAmount,
    required this.clientAmount,
    required this.paymentStatus,
    this.paymentReference,
    required this.insertedBy,
    required this.insertedDate,
    required this.insertedByName,
    required this.zoneName,
    required this.commandName,
    required this.offenceName,
    required this.offenceCode,
    required this.offenceShort,
    required this.amount,
    required this.firstName,
    required this.surname,
    required this.offenderName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.plateColorName,
    required this.plateTypeName,
    required this.eventTypeName,
    required this.vehicleBrandName,
    required this.vehicleColorName,
    required this.vehicleTypeName,
  });

  @override
  List<Object?> get props => [
    id,
    zoneId,
    commandId,
    offenceId,
    offenderId,
    plateColorId,
    plateTypeId,
    eventTypeId,
    vehicleBrandId,
    vehicleColorId,
    vehicleTypeId,
    pcnNumber,
    plateNumber,
    violationDate,
    status,
    paymentMethod,
    paymentPlatform,
    paymentAmount,
    paymentDate,
    sltsAmount,
    clientAmount,
    paymentStatus,
    paymentReference,
    insertedBy,
    insertedDate,
    insertedByName,
    zoneName,
    commandName,
    offenceName,
    offenceCode,
    offenceShort,
    amount,
    firstName,
    surname,
    offenderName,
    phoneNumber,
    emailAddress,
    plateColorName,
    plateTypeName,
    eventTypeName,
    vehicleBrandName,
    vehicleColorName,
    vehicleTypeName,
  ];
}
