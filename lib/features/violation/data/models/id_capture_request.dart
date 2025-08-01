import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/id_capture_notifier.dart';

part 'id_capture_request.g.dart';

@JsonSerializable()
class IdCaptureRequest {
  @JsonKey(name: 'drivers_license')
  final bool driversLicense;

  @JsonKey(name: 'vehicle_particulars')
  final bool vehicleParticulars;

  @JsonKey(name: 'comment')
  final String comment;

  const IdCaptureRequest({
    required this.driversLicense,
    required this.vehicleParticulars,
    required this.comment,
  });

  // Factory to build from a state object (optional, add your type as needed)
  factory IdCaptureRequest.fromState(IdCaptureState state) {
    return IdCaptureRequest(
      driversLicense: state.hasDriversLicense,
      vehicleParticulars: state.hasVehicleParticulars,
      comment: state.comment.trim(),
    );
  }

  factory IdCaptureRequest.fromJson(Map<String, dynamic> json) =>
      _$IdCaptureRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IdCaptureRequestToJson(this);
}
