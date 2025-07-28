import 'package:json_annotation/json_annotation.dart';

part 'run_plate_request.g.dart';

@JsonSerializable()
class RunPlateRequest {
  final String search;
  RunPlateRequest({required this.search});
  factory RunPlateRequest.fromJson(Map<String, dynamic> json) =>
      _$RunPlateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RunPlateRequestToJson(this);
}
