import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the current stage of the splash screen
enum SplashStage { street, appLogo, done }

final splashStageProvider =
    StateNotifierProvider<SplashStageNotifier, SplashStage>(
      (ref) => SplashStageNotifier(),
    );

class SplashStageNotifier extends StateNotifier<SplashStage> {
  SplashStageNotifier() : super(SplashStage.street) {
    _startSequence();
  }

  void _startSequence() async {
    await Future.delayed(const Duration(seconds: 3));
    state = SplashStage.appLogo;

    await Future.delayed(const Duration(milliseconds: 3100));
    state = SplashStage.done;
  }
}
