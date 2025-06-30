import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginFormStage {
  none,
  emailFilled,
  passwordFilled,
  formFilled,
}

bool isPasswordVisible = false;

class LoginFormState {
  final LoginFormStage stage;
  final bool isLoginClicked;
  final bool isPasswordVisible;
  final bool emailValid;
  final bool emailTouched;

  const LoginFormState({
    this.stage = LoginFormStage.none,
    this.isLoginClicked = false,
    this.isPasswordVisible = false,
    this.emailValid = false,
    this.emailTouched = false,
  });

  LoginFormState copyWith({
    LoginFormStage? stage,
    bool? isLoginClicked,
    bool? isPasswordVisible,
    bool? emailValid,
    bool? emailTouched,
  }) {
    return LoginFormState(
      stage: stage ?? this.stage,
      isLoginClicked: isLoginClicked ?? this.isLoginClicked,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      emailValid: emailValid ?? this.emailValid,
      emailTouched: emailTouched ?? this.emailTouched,
    );
  }
}

final loginFormProvider =
  StateNotifierProvider<LoginFormNotifier, LoginFormState>(
    (ref) => LoginFormNotifier(),
  );


class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  bool _emailFilled = false;
  bool _passwordFilled = false;
  bool _isPasswordVisible = false;

  void setFieldToFilled(String field, {String? emailValue}) {
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

  void setFieldToUnfilled(String field) {
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

  void markEmailTouched() {
    state = state.copyWith(emailTouched: true);
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    state = state.copyWith(isPasswordVisible: _isPasswordVisible);
  }

  void markLoginClicked() {
    state = state.copyWith(isLoginClicked: true);
  }

  void reset() {
    _emailFilled = false;
    _passwordFilled = false;
    _isPasswordVisible = false;
    state = const LoginFormState();
  }
}
