import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/action_notifier.dart';

part 'action_request.g.dart';

enum ActionType {
  driversLicense('Drivers Licence'),
  vehicleParticulars('Vehicle Particulars'),
  vehicleImpounded('Vehicle Impounded');

  final String label;
  const ActionType(this.label);

  // convenience if you want a short name for serialization / display
  String get value => label;
}

@JsonSerializable()
class ActionRequest {
  @JsonKey(name: 'pcn')
  final List<String> pcn;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'status', defaultValue: 'successful')
  final String status;

  @JsonKey(name: 'comment')
  final String comment;

  const ActionRequest({
    required this.pcn,
    required this.type,
    this.status = 'successful',
    required this.comment,
  });

  // Factory to build from a state object (optional, add your type as needed)
  factory ActionRequest.fromState(ActionState state) {
    return ActionRequest(
      pcn: state.pcns,
      type: state.type.value,
      comment: state.comment.trim(),
    );
  }

  factory ActionRequest.fromJson(Map<String, dynamic> json) =>
      _$ActionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ActionRequestToJson(this);
}
