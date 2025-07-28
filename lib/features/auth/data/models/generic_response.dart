import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse {
  final String message;
  final dynamic data;

  GenericResponse({required this.message, this.data});

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
