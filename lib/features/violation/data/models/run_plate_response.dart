import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';

part 'run_plate_response.g.dart';

@JsonSerializable()
class RunPlateResponse {
  final String? message;
  final List<ViolationModel>? data;
  RunPlateResponse({required this.message, required this.data});
  factory RunPlateResponse.fromJson(Map<String, dynamic> json) =>
      _$RunPlateResponseFromJson(json);
}
