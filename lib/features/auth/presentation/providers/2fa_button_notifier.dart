import 'package:flutter_riverpod/flutter_riverpod.dart';


final buttonStateProvider = StateNotifierProvider<ButtonNotifier, bool>((ref) {
  return ButtonNotifier();
});

class ButtonNotifier extends StateNotifier<bool> {
  ButtonNotifier() : super(false);

  void markButtonClicked() {
    state = true;
  }

  void clear() => state = false;
}