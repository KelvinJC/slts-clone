import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/pagination.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/domain/repositories/violation_repository.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../../../core/errors/failures.dart';

class PatrolModeState {
  final bool loading;
  final List<Violation>? violations;
  final Pagination? pagination;
  final String? error;

  const PatrolModeState({
    this.loading = false,
    this.violations,
    this.error,
    this.pagination,
  });

  PatrolModeState copyWith({
    bool? loading,
    List<Violation>? violations,
    String? error,
    Pagination? pagination,
  }) {
    return PatrolModeState(
      loading: loading ?? this.loading,
      violations: violations ?? this.violations,
      error: error,
      pagination: pagination ?? this.pagination,
    );
  }
}

/// A shortcut to read other providers from inside this notifier.
typedef Reader = T Function<T>(ProviderListenable<T> provider);

class PatrolModeNotifier extends StateNotifier<PatrolModeState> {
  PatrolModeNotifier(this._repo, this._read) : super(const PatrolModeState());

  final ViolationRepository _repo;
  final Reader _read;

  /// Fetch all past violations from the server (or local cache).
  Future<void> fetchPatrolMode({int page = 1, int limit = 15}) async {
    state = state.copyWith(loading: true, error: null);
    try {
      int userId = _read(authNotifierProvider).user?.id ?? 0;
      userId = 19;
      final (list, pagination) = await _repo.getPatrolMode(
        userId,
        page: page,
        limit: limit,
      );
      state = state.copyWith(
        loading: false,
        violations: list,
        pagination: pagination,
      );
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f.displayMessage);
    }
  }
}

final patrolModeProvider =
    StateNotifierProvider<PatrolModeNotifier, PatrolModeState>(
      (ref) =>
          PatrolModeNotifier(ref.read(violationRepositoryProvider), ref.read),
    );
