import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/entities/violation.dart';
import '../../domain/repositories/violation_repository.dart';
import '../../../../core/errors/failures.dart';

class RunPlateState {
  final bool loading;
  final List<Violation>? results;
  final String? error;
  const RunPlateState({this.loading = false, this.results, this.error});
  RunPlateState copyWith({
    bool? loading,
    List<Violation>? results,
    String? error,
  }) {
    return RunPlateState(
      loading: loading ?? this.loading,
      results: results,
      error: error,
    );
  }
}

class RunPlateNotifier extends StateNotifier<RunPlateState> {
  RunPlateNotifier(this._repo) : super(const RunPlateState());
  final ViolationRepository _repo;

  Future<void> search(String plate) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final list = await _repo.runPlateNumber(plate);
      state = state.copyWith(loading: false, results: list);
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f.displayMessage);
    }
  }
}

final runPlateProvider = StateNotifierProvider<RunPlateNotifier, RunPlateState>(
  (ref) => RunPlateNotifier(ref.read(violationRepositoryProvider)),
);
