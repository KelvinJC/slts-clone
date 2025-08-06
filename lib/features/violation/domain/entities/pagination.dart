import 'package:equatable/equatable.dart';

/// Domain-level representation of pagination information.
class Pagination extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [page, limit, total, totalPages];
}
