import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation_file.dart';

part 'violation_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ViolationModel {
  @HiveField(0)
  @JsonKey(name: 'violation_id', defaultValue: 0)
  final int? id;

  @HiveField(1)
  @JsonKey(name: 'zone_id', defaultValue: 0)
  final int? zoneId;

  @HiveField(2)
  @JsonKey(name: 'command_id', defaultValue: 0)
  final int? commandId;

  @HiveField(3)
  @JsonKey(name: 'offence_id', defaultValue: 0)
  final int? offenceId;

  @HiveField(4)
  @JsonKey(name: 'offender_id', defaultValue: 0)
  final int? offenderId;

  @HiveField(5)
  @JsonKey(name: 'plate_color_id', defaultValue: 0)
  final int? plateColorId;

  @HiveField(6)
  @JsonKey(name: 'plate_type_id', defaultValue: 0)
  final int? plateTypeId;

  @HiveField(7)
  @JsonKey(name: 'event_type_id', defaultValue: 0)
  final int? eventTypeId;

  @HiveField(8)
  @JsonKey(name: 'vehicle_brand_id', defaultValue: 0)
  final int? vehicleBrandId;

  @HiveField(9)
  @JsonKey(name: 'vehicle_color_id', defaultValue: 0)
  final int? vehicleColorId;

  @HiveField(10)
  @JsonKey(name: 'vehicle_type_id', defaultValue: 0)
  final int? vehicleTypeId;

  @HiveField(11)
  @JsonKey(name: 'pcn', defaultValue: '')
  final String? pcnNumber;

  @HiveField(12)
  @JsonKey(name: 'plate_no', defaultValue: '')
  final String? plateNumber;

  @HiveField(13)
  @JsonKey(name: 'violation_date', defaultValue: '')
  final String? violationDateIso;

  @HiveField(14)
  @JsonKey(name: 'status', defaultValue: '')
  final String? status;

  @HiveField(15)
  @JsonKey(name: 'payment_method', defaultValue: '')
  final String? paymentMethod;

  @HiveField(16)
  @JsonKey(name: 'payment_platform', defaultValue: '')
  final String? paymentPlatform;

  @HiveField(17)
  @JsonKey(name: 'payment_amount', defaultValue: 0)
  final int? paymentAmount;

  @HiveField(18)
  @JsonKey(name: 'payment_date', defaultValue: '')
  final String? paymentDateIso;

  @HiveField(19)
  @JsonKey(name: 'slts_amount', defaultValue: 0)
  final int? sltsAmount;

  @HiveField(20)
  @JsonKey(name: 'client_amount', defaultValue: 0)
  final int? clientAmount;

  @HiveField(21)
  @JsonKey(name: 'payment_status', defaultValue: '')
  final String? paymentStatus;

  @HiveField(22)
  @JsonKey(name: 'payment_reference', defaultValue: '')
  final String? paymentReference;

  @HiveField(23)
  @JsonKey(name: 'inserted_by', defaultValue: 0)
  final int? insertedBy;

  @HiveField(24)
  @JsonKey(name: 'inserted_date', defaultValue: '')
  final String? insertedDateIso;

  @HiveField(25)
  @JsonKey(name: 'inserted_by_name', defaultValue: '')
  final String? insertedByName;

  @HiveField(26)
  @JsonKey(name: 'zone_name', defaultValue: '')
  final String? zoneName;

  @HiveField(27)
  @JsonKey(name: 'command_name', defaultValue: '')
  final String? commandName;

  @HiveField(28)
  @JsonKey(name: 'offence_name', defaultValue: '')
  final String? offenceName;

  @HiveField(29)
  @JsonKey(name: 'offence_code', defaultValue: '')
  final String? offenceCode;

  @HiveField(30)
  @JsonKey(name: 'offence_short', defaultValue: '')
  final String? offenceShort;

  @HiveField(31)
  @JsonKey(name: 'amount', defaultValue: 0)
  final int? amount;

  @HiveField(32)
  @JsonKey(name: 'first_name', defaultValue: '')
  final String? firstName;

  @HiveField(33)
  @JsonKey(name: 'surname', defaultValue: '')
  final String? surname;

  @HiveField(34)
  @JsonKey(name: 'offender_name', defaultValue: '')
  final String? offenderName;

  @HiveField(35)
  @JsonKey(name: 'phone_number', defaultValue: '')
  final String? phoneNumber;

  @HiveField(36)
  @JsonKey(name: 'email_address', defaultValue: '')
  final String? emailAddress;

  @HiveField(37)
  @JsonKey(name: 'plate_color_name', defaultValue: '')
  final String? plateColorName;

  @HiveField(38)
  @JsonKey(name: 'plate_type_name', defaultValue: '')
  final String? plateTypeName;

  @HiveField(39)
  @JsonKey(name: 'event_type_name', defaultValue: '')
  final String? eventTypeName;

  @HiveField(40)
  @JsonKey(name: 'vehicle_brand_name', defaultValue: '')
  final String? vehicleBrandName;

  @HiveField(41)
  @JsonKey(name: 'vehicle_color_name', defaultValue: '')
  final String? vehicleColorName;

  @HiveField(42)
  @JsonKey(name: 'vehicle_type_name', defaultValue: '')
  final String? vehicleTypeName;

  ViolationModel({
    this.id,
    this.zoneId,
    this.commandId,
    this.offenceId,
    this.offenderId,
    this.plateColorId,
    this.plateTypeId,
    this.eventTypeId,
    this.vehicleBrandId,
    this.vehicleColorId,
    this.vehicleTypeId,
    this.pcnNumber,
    this.plateNumber,
    this.violationDateIso,
    this.status,
    this.paymentMethod,
    this.paymentPlatform,
    this.paymentAmount,
    this.paymentDateIso,
    this.sltsAmount,
    this.clientAmount,
    this.paymentStatus,
    this.paymentReference,
    this.insertedBy,
    this.insertedDateIso,
    this.insertedByName,
    this.zoneName,
    this.commandName,
    this.offenceName,
    this.offenceCode,
    this.offenceShort,
    this.amount,
    this.firstName,
    this.surname,
    this.offenderName,
    this.phoneNumber,
    this.emailAddress,
    this.plateColorName,
    this.plateTypeName,
    this.eventTypeName,
    this.vehicleBrandName,
    this.vehicleColorName,
    this.vehicleTypeName,
  });

  factory ViolationModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationModelToJson(this);

  /// Convert to your domain entity, with fallbacks if you like:
  Violation toEntity({List<ViolationFile>? files}) => Violation(
    id: id ?? 0,
    zoneId: zoneId ?? 0,
    commandId: commandId ?? 0,
    offenceId: offenceId ?? 0,
    offenderId: offenderId ?? 0,
    plateColorId: plateColorId ?? 0,
    plateTypeId: plateTypeId ?? 0,
    eventTypeId: eventTypeId ?? 0,
    vehicleBrandId: vehicleBrandId ?? 0,
    vehicleColorId: vehicleColorId ?? 0,
    vehicleTypeId: vehicleTypeId ?? 0,
    pcnNumber: pcnNumber ?? '',
    plateNumber: plateNumber ?? '',
    violationDate:
        violationDateIso != null && violationDateIso?.isNotEmpty == true
        ? DateTime.parse(violationDateIso!)
        : DateTime.fromMillisecondsSinceEpoch(0),
    status: status ?? '',
    paymentMethod: paymentMethod,
    paymentPlatform: paymentPlatform,
    paymentAmount: paymentAmount ?? 0,
    paymentDate: (paymentDateIso != null && paymentDateIso!.isNotEmpty)
        ? DateTime.parse(paymentDateIso!)
        : null,
    sltsAmount: sltsAmount ?? 0,
    clientAmount: clientAmount ?? 0,
    paymentStatus: paymentStatus ?? '',
    paymentReference: paymentReference,
    insertedBy: insertedBy ?? 0,
    insertedDate: insertedDateIso != null && insertedDateIso?.isNotEmpty == true
        ? DateTime.parse(insertedDateIso!)
        : DateTime.fromMillisecondsSinceEpoch(0),
    insertedByName: insertedByName ?? '',
    zoneName: zoneName ?? '',
    commandName: commandName ?? '',
    offenceName: offenceName ?? '',
    offenceCode: offenceCode ?? '',
    offenceShort: offenceShort ?? '',
    amount: amount ?? 0,
    firstName: firstName ?? '',
    surname: surname ?? '',
    offenderName: offenderName ?? '',
    phoneNumber: phoneNumber ?? '',
    emailAddress: emailAddress ?? '',
    plateColorName: plateColorName ?? '',
    plateTypeName: plateTypeName ?? '',
    eventTypeName: eventTypeName ?? '',
    vehicleBrandName: vehicleBrandName ?? '',
    vehicleColorName: vehicleColorName ?? '',
    vehicleTypeName: vehicleTypeName ?? '',
    files: files ?? [],
  );
}
