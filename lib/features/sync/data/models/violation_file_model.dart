import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation_file.dart';

part 'violation_file_model.g.dart';

@JsonSerializable()
class ViolationFileModel {
  @JsonKey(name: 'file_id')
  final int fileId;

  @JsonKey(name: 'violation_id')
  final int violationId;

  @JsonKey(name: 'file_name', defaultValue: '')
  final String fileName;

  @JsonKey(name: 'file_size', defaultValue: 0)
  final int fileSize;

  @JsonKey(name: 'file_type', defaultValue: '')
  final String fileType;

  @JsonKey(name: 'file_path', defaultValue: '')
  final String filePath;

  @JsonKey(name: 'is_video', defaultValue: 0)
  final int isVideo;

  @JsonKey(name: 'file_length', defaultValue: 0)
  final int fileLength;

  @JsonKey(name: 'inserted_by', defaultValue: 0)
  final int insertedBy;

  @JsonKey(name: 'inserted_date')
  final String insertedDate;

  ViolationFileModel({
    required this.fileId,
    required this.violationId,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
    required this.filePath,
    required this.isVideo,
    required this.fileLength,
    required this.insertedBy,
    required this.insertedDate,
  });

  factory ViolationFileModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationFileModelToJson(this);

  ViolationFile toEntity() => ViolationFile(
    fileId: fileId,
    violationId: violationId,
    fileName: fileName,
    fileSize: fileSize,
    fileType: fileType,
    filePath: filePath,
    isVideo: isVideo,
    fileLength: fileLength,
    insertedBy: insertedBy,
    insertedDate: insertedDate,
  );
}
