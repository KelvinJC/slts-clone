import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/email_field_interfaces.dart';

class ForgotPwdFormState implements EmailFormState {
  final bool isSendLinkClicked;
  @override
  final bool emailValid;
  @override
  final bool emailFieldTouched;

  const ForgotPwdFormState({
    this.isSendLinkClicked = false,
    this.emailValid = false,
    this.emailFieldTouched = false,
  });

  ForgotPwdFormState copyWith({
    bool? isSendLinkClicked,
    bool? emailValid,
    bool? emailFieldTouched,
  }) {
    return ForgotPwdFormState(
      isSendLinkClicked: isSendLinkClicked ?? this.isSendLinkClicked,
      emailValid: emailValid ?? this.emailValid,
      emailFieldTouched: emailFieldTouched ?? this.emailFieldTouched,
    );
  }
}

final forgotPwdFormProvider =
  StateNotifierProvider<ForgotPwdFormFormNotifier, ForgotPwdFormState>(
    (ref) => ForgotPwdFormFormNotifier(),
  );


class ForgotPwdFormFormNotifier extends StateNotifier<ForgotPwdFormState> implements EmailFieldNotifier<ForgotPwdFormState> {
  ForgotPwdFormFormNotifier() : super(const ForgotPwdFormState());

  @override
  void setFieldToFilled(String? fieldName, {required String emailValue}) {
      final isValid = _validateEmail(emailValue);
      state = state.copyWith(emailValid: isValid);
  }

  @override
  void setFieldToUnfilled(String? fieldName) { // Must match abstract signature
    state = state.copyWith(emailValid: false, isSendLinkClicked: false);
  }

  @override
  void markEmailFieldTouched() {
    state = state.copyWith(emailFieldTouched: true);
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void markButtonClicked() {
    state = state.copyWith(isSendLinkClicked: true);
  }

  void reset() {
    state = const ForgotPwdFormState();
  }
}
