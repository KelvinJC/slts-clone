import 'package:equatable/equatable.dart';

/// Domain-level representation of a violation file.
class ViolationFile extends Equatable {
  final int fileId;
  final int violationId;
  final String fileName;
  final int fileSize;
  final String fileType;
  final String filePath;
  final int isVideo;
  final int fileLength;
  final int insertedBy;
  final String insertedDate;

  const ViolationFile({
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

  @override
  List<Object?> get props => [
    fileId,
    violationId,
    fileName,
    fileSize,
    fileType,
    filePath,
    isVideo,
    fileLength,
    insertedBy,
    insertedDate,
  ];
}
