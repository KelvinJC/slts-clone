import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';
part 'create_violation_request.g.dart';

@JsonSerializable()
class CreateViolationRequest {
  final String offence,
      eventType,
      date,
      zone,
      command,
      firstName,
      surname,
      phone;
  final String plate, plateType, plateColor, brand, vehicleType, vehicleColor;
  final List<String> mediaPaths;

  CreateViolationRequest({
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
    required this.mediaPaths,
  });

  /// New: construct from your local ViolationModel
  factory CreateViolationRequest.fromViolationModel(ViolationModel v) {
    return CreateViolationRequest(
      offence: v.offenceName,
      eventType: v.eventTypeName,
      date: v.violationDateIso,
      zone: v.zoneName,
      command: v.commandName,
      firstName: v.firstName,
      surname: v.surname,
      phone: v.phoneNumber,
      plate: v.plateNumber,
      plateType: v.plateTypeName,
      plateColor: v.plateColorName,
      brand: v.vehicleBrandName,
      vehicleType: v.vehicleTypeName,
      vehicleColor: v.vehicleColorName,
      // mediaPaths: List<String>.from(v.mediaPaths),
      mediaPaths: [],
    );
  }

  factory CreateViolationRequest.fromJson(Map<String, dynamic> j) =>
      _$CreateViolationRequestFromJson(j);
  Map<String, dynamic> toJson() => _$CreateViolationRequestToJson(this);
}
