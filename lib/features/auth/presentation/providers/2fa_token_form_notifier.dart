import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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