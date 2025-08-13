import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/pagination.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  @JsonKey(defaultValue: 1)
  final int page;

  @JsonKey(defaultValue: 10)
  final int limit;

  @JsonKey(defaultValue: 0)
  final int total;

  @JsonKey(name: 'totalPages', defaultValue: 0)
  final int totalPages;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  Pagination toEntity() => Pagination(
    page: page,
    limit: limit,
    total: total,
    totalPages: totalPages,
  );
}
