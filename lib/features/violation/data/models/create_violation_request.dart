import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';

part 'create_violation_request.g.dart';

@JsonSerializable()
class CreateViolationRequest {
  final String id;
  @JsonKey(name: 'plate')
  final String plateNumber;
  @JsonKey(name: 'offence')
  final String offenceType;
  final String timestamp;
  final String? photoPath;

  CreateViolationRequest({
    required this.id,
    required this.plateNumber,
    required this.offenceType,
    required this.timestamp,
    this.photoPath,
  });

  factory CreateViolationRequest.fromViolationModel(ViolationModel v) {
    return CreateViolationRequest(
      id: v.id,
      plateNumber: v.plateNumber,
      offenceType: v.offenceType,
      timestamp: v.timestamp.toIso8601String(),
      photoPath: v.photoPath,
    );
  }

  factory CreateViolationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateViolationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateViolationRequestToJson(this);
}
