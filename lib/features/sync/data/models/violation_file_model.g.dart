// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationFileModel _$ViolationFileModelFromJson(Map<String, dynamic> json) =>
    ViolationFileModel(
      fileId: (json['file_id'] as num).toInt(),
      violationId: (json['violation_id'] as num).toInt(),
      fileName: json['file_name'] as String? ?? '',
      fileSize: (json['file_size'] as num?)?.toInt() ?? 0,
      fileType: json['file_type'] as String? ?? '',
      filePath: json['file_path'] as String? ?? '',
      isVideo: (json['is_video'] as num?)?.toInt() ?? 0,
      fileLength: (json['file_length'] as num?)?.toInt() ?? 0,
      insertedBy: (json['inserted_by'] as num?)?.toInt() ?? 0,
      insertedDate: json['inserted_date'] as String,
    );

Map<String, dynamic> _$ViolationFileModelToJson(ViolationFileModel instance) =>
    <String, dynamic>{
      'file_id': instance.fileId,
      'violation_id': instance.violationId,
      'file_name': instance.fileName,
      'file_size': instance.fileSize,
      'file_type': instance.fileType,
      'file_path': instance.filePath,
      'is_video': instance.isVideo,
      'file_length': instance.fileLength,
      'inserted_by': instance.insertedBy,
      'inserted_date': instance.insertedDate,
    };
