import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/resend_link_notifier.dart';

part 'resend_link_request.g.dart';

@JsonSerializable()
class ResendLinkRequest {
  @JsonKey(name: 'email')
  final String email;

  const ResendLinkRequest({required this.email});

  // Factory to build from a state object (optional, add your type as needed)
  factory ResendLinkRequest.fromState(ResendLinkState state) {
    return ResendLinkRequest(email: state.email.trim());
  }

  factory ResendLinkRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendLinkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendLinkRequestToJson(this);
}
