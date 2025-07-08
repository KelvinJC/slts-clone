import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';

part 'violation_model.g.dart';

@HiveType(typeId: 1) // ← pick a unique typeId per model
@JsonSerializable()
class ViolationModel {
  @HiveField(0)
  @JsonKey(name: 'violation_id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'zone_id')
  final int zoneId;

  @HiveField(2)
  @JsonKey(name: 'command_id')
  final int commandId;

  @HiveField(3)
  @JsonKey(name: 'offence_id')
  final int offenceId;

  @HiveField(4)
  @JsonKey(name: 'offender_id')
  final int offenderId;

  @HiveField(5)
  @JsonKey(name: 'plate_color_id')
  final int plateColorId;

  @HiveField(6)
  @JsonKey(name: 'plate_type_id')
  final int plateTypeId;

  @HiveField(7)
  @JsonKey(name: 'event_type_id')
  final int eventTypeId;

  @HiveField(8)
  @JsonKey(name: 'vehicle_brand_id')
  final int vehicleBrandId;

  @HiveField(9)
  @JsonKey(name: 'vehicle_color_id')
  final int vehicleColorId;

  @HiveField(10)
  @JsonKey(name: 'vehicle_type_id')
  final int vehicleTypeId;

  @HiveField(11)
  @JsonKey(name: 'pcn')
  final String pcnNumber;

  @HiveField(12)
  @JsonKey(name: 'plate_no')
  final String plateNumber;

  @HiveField(13)
  @JsonKey(name: 'violation_date')
  final String violationDateIso;

  @HiveField(14)
  final String status;

  @HiveField(15)
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @HiveField(16)
  @JsonKey(name: 'payment_platform')
  final String? paymentPlatform;

  @HiveField(17)
  @JsonKey(name: 'payment_amount')
  final int paymentAmount;

  @HiveField(18)
  @JsonKey(name: 'payment_date')
  final String? paymentDateIso;

  @HiveField(19)
  @JsonKey(name: 'slts_amount')
  final int sltsAmount;

  @HiveField(20)
  @JsonKey(name: 'client_amount')
  final int clientAmount;

  @HiveField(21)
  @JsonKey(name: 'payment_status')
  final String paymentStatus;

  @HiveField(22)
  @JsonKey(name: 'payment_reference')
  final String? paymentReference;

  @HiveField(23)
  @JsonKey(name: 'inserted_by')
  final int insertedBy;

  @HiveField(24)
  @JsonKey(name: 'inserted_date')
  final String insertedDateIso;

  @HiveField(25)
  @JsonKey(name: 'inserted_by_name')
  final String insertedByName;

  @HiveField(26)
  @JsonKey(name: 'zone_name')
  final String zoneName;

  @HiveField(27)
  @JsonKey(name: 'command_name')
  final String commandName;

  @HiveField(28)
  @JsonKey(name: 'offence_name')
  final String offenceName;

  @HiveField(29)
  @JsonKey(name: 'offence_code')
  final String offenceCode;

  @HiveField(30)
  @JsonKey(name: 'offence_short')
  final String offenceShort;

  @HiveField(31)
  final int amount;

  @HiveField(32)
  @JsonKey(name: 'first_name')
  final String firstName;

  @HiveField(33)
  final String surname;

  @HiveField(34)
  @JsonKey(name: 'offender_name')
  final String offenderName;

  @HiveField(35)
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @HiveField(36)
  @JsonKey(name: 'email_address')
  final String emailAddress;

  @HiveField(37)
  @JsonKey(name: 'plate_color_name')
  final String plateColorName;

  @HiveField(38)
  @JsonKey(name: 'plate_type_name')
  final String plateTypeName;

  @HiveField(39)
  @JsonKey(name: 'event_type_name')
  final String eventTypeName;

  @HiveField(40)
  @JsonKey(name: 'vehicle_brand_name')
  final String vehicleBrandName;

  @HiveField(41)
  @JsonKey(name: 'vehicle_color_name')
  final String vehicleColorName;

  @HiveField(42)
  @JsonKey(name: 'vehicle_type_name')
  final String vehicleTypeName;

  ViolationModel({
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
    required this.violationDateIso,
    required this.status,
    this.paymentMethod,
    this.paymentPlatform,
    required this.paymentAmount,
    this.paymentDateIso,
    required this.sltsAmount,
    required this.clientAmount,
    required this.paymentStatus,
    this.paymentReference,
    required this.insertedBy,
    required this.insertedDateIso,
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

  /// JSON
  factory ViolationModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ViolationModelToJson(this);

  /// toEntity
  Violation toEntity() => Violation(
    id: id,
    zoneId: zoneId,
    commandId: commandId,
    offenceId: offenceId,
    offenderId: offenderId,
    plateColorId: plateColorId,
    plateTypeId: plateTypeId,
    eventTypeId: eventTypeId,
    vehicleBrandId: vehicleBrandId,
    vehicleColorId: vehicleColorId,
    vehicleTypeId: vehicleTypeId,
    pcnNumber: pcnNumber,
    plateNumber: plateNumber,
    violationDate: DateTime.parse(violationDateIso),
    status: status,
    paymentMethod: paymentMethod,
    paymentPlatform: paymentPlatform,
    paymentAmount: paymentAmount,
    paymentDate: paymentDateIso != null
        ? DateTime.parse(paymentDateIso!)
        : null,
    sltsAmount: sltsAmount,
    clientAmount: clientAmount,
    paymentStatus: paymentStatus,
    paymentReference: paymentReference,
    insertedBy: insertedBy,
    insertedDate: DateTime.parse(insertedDateIso),
    insertedByName: insertedByName,
    zoneName: zoneName,
    commandName: commandName,
    offenceName: offenceName,
    offenceCode: offenceCode,
    offenceShort: offenceShort,
    amount: amount,
    firstName: firstName,
    surname: surname,
    offenderName: offenderName,
    phoneNumber: phoneNumber,
    emailAddress: emailAddress,
    plateColorName: plateColorName,
    plateTypeName: plateTypeName,
    eventTypeName: eventTypeName,
    vehicleBrandName: vehicleBrandName,
    vehicleColorName: vehicleColorName,
    vehicleTypeName: vehicleTypeName,
  );
}
