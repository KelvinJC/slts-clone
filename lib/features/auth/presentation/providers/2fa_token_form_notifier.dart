import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ButtonStage { transparent, gradient, clicked }

class ButtonNotifier extends StateNotifier<ButtonStage> {
  ButtonNotifier() : super(ButtonStage.transparent);

  void markButtonClicked()  => state = ButtonStage.clicked;
  void setBtnColorToGradient() => state = ButtonStage.gradient;
  void clear() => state = ButtonStage.transparent;
}

final buttonStateProvider = StateNotifierProvider<ButtonNotifier, ButtonStage>((ref) {
  return ButtonNotifier();
});

final pinControllerProvider = Provider.autoDispose<TextEditingController>(
      (ref) {
    final controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  },
);

final focusNodeProvider = Provider.autoDispose<FocusNode>(
      (ref) {
    final node = FocusNode();
    ref.onDispose(() => node.dispose());
    return node;
  },
);

final formKeyProvider = Provider.autoDispose<GlobalKey<FormState>>(
      (ref) => GlobalKey<FormState>(),
);

