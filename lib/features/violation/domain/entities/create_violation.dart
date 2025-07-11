class CreateViolation {
  final int zoneId;
  final int commandId;
  final int offenceId;
  final String firstName;
  final String surname;
  final String phoneNumber;
  final String emailAddress;
  final int plateColorId;
  final int plateTypeId;
  final int eventTypeId;
  final int vehicleBrandId;
  final int vehicleColorId;
  final int vehicleTypeId;
  final String pcn;
  final String plateNo;
  final DateTime violationDate;
  final int paymentAmount;
  final int sltsAmount;
  final int clientAmount;
  final String insertedBy;

  CreateViolation({
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
  });
}
