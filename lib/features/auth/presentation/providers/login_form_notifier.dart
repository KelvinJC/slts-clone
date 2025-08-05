import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/email_field_interfaces.dart';

enum LoginFormStage {
  none,
  emailFilled,
  passwordFilled,
  formFilled,
}

bool isPasswordVisible = false;

class LoginFormState implements EmailFormState {
  final LoginFormStage stage;
  final bool isLoginClicked;
  final bool isPasswordVisible;
  @override
  final bool emailValid;
  @override
  final bool emailFieldTouched;

  const LoginFormState({
    this.stage = LoginFormStage.none,
    this.isLoginClicked = false,
    this.isPasswordVisible = false,
    this.emailValid = false,
    this.emailFieldTouched = false,
  });

  LoginFormState copyWith({
    LoginFormStage? stage,
    bool? isLoginClicked,
    bool? isPasswordVisible,
    bool? emailValid,
    bool? emailFieldTouched,
  }) {
    return LoginFormState(
      stage: stage ?? this.stage,
      isLoginClicked: isLoginClicked ?? this.isLoginClicked,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      emailValid: emailValid ?? this.emailValid,
      emailFieldTouched: emailFieldTouched ?? this.emailFieldTouched,
    );
  }
}

final loginFormProvider =
  StateNotifierProvider<LoginFormNotifier, LoginFormState>(
    (ref) => LoginFormNotifier(),
  );

class LoginFormNotifier extends StateNotifier<LoginFormState> implements EmailFieldNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  bool _emailFilled = false;
  bool _passwordFilled = false;
  bool _isPasswordVisible = false;

  @override
   void setFieldToFilled(String? field, {required String emailValue}) {
    if (field == 'email') {
      _emailFilled = true;

      final isValid = _validateEmail(emailValue ?? '');
      state = state.copyWith(emailValid: isValid);
    }

    if (field == 'password') _passwordFilled = true;

    LoginFormStage newStage;
    if (state.emailValid && _passwordFilled) {
      newStage = LoginFormStage.formFilled;
    } else if (_emailFilled) {
      newStage = LoginFormStage.emailFilled;
    } else if (_passwordFilled) {
      newStage = LoginFormStage.passwordFilled;
    } else {
      newStage = LoginFormStage.none;
    }

    state = state.copyWith(stage: newStage);
  }

  @override
  void setFieldToUnfilled(String? field) {
    if (field == 'email') _emailFilled = false;
    if (field == 'password') _passwordFilled = false;

    LoginFormStage newStage;
    if (_emailFilled) {
      newStage = LoginFormStage.emailFilled;
    }
    else if (_passwordFilled) {
      newStage = LoginFormStage.passwordFilled;
    }
    else {
      newStage = LoginFormStage.none;
    }

    state = state.copyWith(stage: newStage, isLoginClicked: false);
  }

  @override
  void markEmailFieldTouched() {
    state = state.copyWith(emailFieldTouched: true);
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    state = state.copyWith(isPasswordVisible: _isPasswordVisible);
  }

  void markButtonClicked() {
    state = state.copyWith(isLoginClicked: true);
  }

  void reset() {
    _emailFilled = false;
    _passwordFilled = false;
    _isPasswordVisible = false;
    state = const LoginFormState();
  }
}

