import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/data/models/violation_hive_model.dart';

part 'create_violation_request.g.dart';

@JsonSerializable()
class CreateViolationRequest {
  @JsonKey(name: 'zone_id')
  final String zoneId;
  @JsonKey(name: 'command_id')
  final String commandId;
  @JsonKey(name: 'offence_id')
  final String offenceId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'surname')
  final String surname;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'email_address')
  final String emailAddress;
  @JsonKey(name: 'plate_color_id')
  final String plateColorId;
  @JsonKey(name: 'plate_type_id')
  final String plateTypeId;
  @JsonKey(name: 'event_type_id')
  final String eventTypeId;
  @JsonKey(name: 'vehicle_brand_id')
  final String vehicleBrandId;
  @JsonKey(name: 'vehicle_color_id')
  final String vehicleColorId;
  @JsonKey(name: 'vehicle_type_id')
  final String vehicleTypeId;
  @JsonKey(name: 'pcn')
  final String pcn;
  @JsonKey(name: 'plate_no')
  final String plateNo;
  @JsonKey(name: 'violation_date')
  final String violationDate;
  @JsonKey(name: 'payment_amount')
  final String paymentAmount;
  @JsonKey(name: 'slts_amount')
  final String sltsAmount;
  @JsonKey(name: 'client_amount')
  final String clientAmount;
  @JsonKey(name: 'inserted_by')
  final String insertedBy;
  @JsonKey(name: 'violation_files')
  final List<String>? violationFiles;

  CreateViolationRequest({
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

  /// New: construct from your local ViolationModel
  factory CreateViolationRequest.fromViolationModel(ViolationHiveModel v) {
    return CreateViolationRequest(
      zoneId: v.zoneId.toString(),
      commandId: v.commandId.toString(),
      offenceId: v.offenceId.toString(),
      firstName: v.firstName,
      surname: v.surname,
      phoneNumber: v.phoneNumber,
      emailAddress: v.emailAddress,
      plateColorId: v.plateColorId.toString(),
      plateTypeId: v.plateTypeId.toString(),
      eventTypeId: v.eventTypeId.toString(),
      vehicleBrandId: v.vehicleBrandId.toString(),
      vehicleColorId: v.vehicleColorId.toString(),
      vehicleTypeId: v.vehicleTypeId.toString(),
      pcn: v.pcn,
      plateNo: v.plateNo,
      violationDate: v.violationDate.toString(),
      paymentAmount: v.paymentAmount.toString(),
      sltsAmount: v.sltsAmount.toString(),
      clientAmount: v.clientAmount.toString(),
      insertedBy: v.insertedBy,
      violationFiles: v.violationFiles,
      // mediaPaths: List<String>.from(v.mediaPaths),
      // mediaPaths: [],
    );
  }

  ViolationHiveModel toViolationHiveModel() {
    return ViolationHiveModel(
      zoneId: int.parse(zoneId),
      commandId: int.parse(commandId),
      offenceId: int.parse(offenceId),
      firstName: firstName,
      surname: surname,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      plateColorId: int.parse(plateColorId),
      plateTypeId: int.parse(plateTypeId),
      eventTypeId: int.parse(eventTypeId),
      vehicleBrandId: int.parse(vehicleBrandId),
      vehicleColorId: int.parse(vehicleColorId),
      vehicleTypeId: int.parse(vehicleTypeId),
      pcn: pcn,
      plateNo: plateNo,
      violationDate: violationDate,
      paymentAmount: paymentAmount,
      sltsAmount: sltsAmount,
      clientAmount: clientAmount,
      insertedBy: insertedBy,
      violationFiles: violationFiles,
    );
  }

  factory CreateViolationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateViolationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateViolationRequestToJson(this);
}
