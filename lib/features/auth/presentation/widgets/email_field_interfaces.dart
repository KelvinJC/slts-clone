import 'package:flutter_riverpod/flutter_riverpod.dart';


// --- Define an abstract interface or mixin for your form state ---
// This helps ensure that any provider you pass conforms to the expected structure.
abstract class EmailFormState {
  bool get emailFieldTouched;
  bool get emailValid;
}

abstract class EmailFieldNotifier<T extends EmailFormState> extends StateNotifier<T> {
  EmailFieldNotifier(super.state);

  void markEmailFieldTouched();
  void setFieldToFilled(String? fieldName, {required String emailValue});
  void setFieldToUnfilled(String? fieldName);
  void reset();
}