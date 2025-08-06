import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/sync/data/models/pagination_model.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_file_model.dart';
import 'package:slts_enforcer_app/features/sync/data/models/violation_model.dart';

part 'violation_response.g.dart';

@JsonSerializable()
class ViolationResponse {
  final String? message;
  final String? status;
  final List<ViolationModel>? data;
  final PaginationModel? pagination;
  final List<ViolationFileModel>? files;

  ViolationResponse({
    required this.message,
    required this.data,
    this.status,
    this.pagination,
    this.files,
  });
  factory ViolationResponse.fromJson(Map<String, dynamic> json) =>
      _$ViolationResponseFromJson(json);
}
