import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/vehicle_impounded_notifier.dart';

part 'vehicle_impounded_request.g.dart';

@JsonSerializable()
class VehicleImpoundedRequest {
  @JsonKey(name: 'comment')
  final String comment;

  const VehicleImpoundedRequest({required this.comment});

  // Factory to build from a state object (optional, add your type as needed)
  factory VehicleImpoundedRequest.fromState(VehicleImpoundedState state) {
    return VehicleImpoundedRequest(comment: state.comment.trim());
  }

  factory VehicleImpoundedRequest.fromJson(Map<String, dynamic> json) =>
      _$VehicleImpoundedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleImpoundedRequestToJson(this);
}
