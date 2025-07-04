import 'package:flutter_riverpod/flutter_riverpod.dart';

final twoFactorAuthProvider = StateNotifierProvider<TwoFactorAuthFormNotifier, List<String>>((ref) {
  return TwoFactorAuthFormNotifier();
});

class TwoFactorAuthFormNotifier extends StateNotifier<List<String>> {
  TwoFactorAuthFormNotifier() : super(List.filled(6, ''));

  void updateDigit(int index, String value) {
    if (index < 0 || index >= state.length) return;

    final updated = [...state];
    updated[index] = value;
    state = updated;
  }

  void clear() => state = List.filled(6, '');
}
