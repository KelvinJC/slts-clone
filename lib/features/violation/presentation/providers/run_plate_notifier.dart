import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/recent_captures_notifier.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/entities/violation.dart';
import '../../domain/repositories/violation_repository.dart';
import '../../../../core/errors/failures.dart';

/// Immutable state for Run‑Plate lookup
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
      results: loading == true ? null : results ?? this.results,
      error: error,
    );
  }
}

/// A shortcut to read other providers from inside this notifier.
typedef Reader = T Function<T>(ProviderListenable<T> provider);

/// The StateNotifier which owns the controller + business logic
class RunPlateNotifier extends StateNotifier<RunPlateState> {
  RunPlateNotifier(this._repo, this._read)
    : controller = TextEditingController(),
      focusNode = FocusNode(),
      super(const RunPlateState());

  final ViolationRepository _repo;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Reader _read;

  /// Kick off a search based on current controller.text
  Future<List<Violation>?> search() async {
    final plate = controller.text.trim();
    if (plate.isEmpty) return null;

    state = state.copyWith(loading: true, error: null);
    try {
      final list = await _repo.runPlateNumber(plate);
      state = state.copyWith(loading: false, results: list);
      await refreshRecentCaptures();
      return list;
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f.displayMessage);
      return null;
    }
  }

  /// Programmatically set the plate text
  void setPlate(String plate) {
    controller.text = plate;
    controller.selection = TextSelection.collapsed(offset: plate.length);
    focusNode.requestFocus();
  }

  /// Clear both the controller and the state
  void clear() {
    state = const RunPlateState();
    controller.clear();
    focusNode.unfocus();
  }

  /// Reset any error state
  void resetError() {
    state = state.copyWith(error: null);
  }

  Future<void> refreshRecentCaptures() async {
    try {
      await _read(recentCapturesProvider.notifier).fetchRecentCaptures();
    } catch (e) {
      // ignore
      print("Failed to fetch recent captures: $e");
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}

/// The Riverpod provider for read & watch
final runPlateProvider = StateNotifierProvider<RunPlateNotifier, RunPlateState>(
  (ref) => RunPlateNotifier(ref.read(violationRepositoryProvider), ref.read),
);
