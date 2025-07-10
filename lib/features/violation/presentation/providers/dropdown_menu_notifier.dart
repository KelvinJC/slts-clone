import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuStateProvider = StateNotifierProvider<DropDownMenuNotifier, bool>((ref) {
  return DropDownMenuNotifier();
});

class DropDownMenuNotifier extends StateNotifier<bool> {
  DropDownMenuNotifier() : super(false);

  void toggleDropDown()  => state = !state;
  void clear() => state = false;
}
