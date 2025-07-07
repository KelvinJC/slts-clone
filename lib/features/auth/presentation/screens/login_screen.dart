import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/widgets/blank_button_widget.dart';
import 'package:slts_enforcer_app/features/auth/presentation/widgets/email_field_widget.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import '../providers/login_form_notifier.dart';
import 'package:slts_enforcer_app/features/auth/presentation/widgets/app_logo_avatar.dart';
// import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginFormProvider);
    final hp = context.hp;
    final wp = context.wp;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: hp(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogoAvatar(),
                    SizedBox(height: wp(3)),
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                      'Please sign in to continue',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.onBackgroundSurface,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: hp(3)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: EmailField(formProvider: loginFormProvider,),
                    ),
                    SizedBox(height: hp(2)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: TextFormField(
                        onChanged: (String val) {
                          if (val.trim() != '') {
                            ref
                                .read(loginFormProvider.notifier)
                                .setFieldToFilled('password', emailValue: '');
                          } else {
                            ref
                                .read(loginFormProvider.notifier)
                                .setFieldToUnfilled('password');
                          }
                        },
                        obscureText: !loginState.isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: AppColors.onBackgroundSurface2,
                          ),
                          // prefixIcon: Icon(Icons.key),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              ref
                                  .read(loginFormProvider.notifier)
                                  .togglePasswordVisibility();
                            },
                            child: Icon(
                              color: Colors.grey,
                              loginState.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(wp(2)),
                            borderSide: BorderSide(
                              color: AppColors.onBackgroundSurface2,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(wp(2)),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: hp(4)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: loginState.stage == LoginFormStage.formFilled
                          ? const _GradientButton()
                          : const BlankButton(text: 'Login'),
                    ),
                    SizedBox(height: hp(4)),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, '/forgotPassword');
                      },
                      child: Text(
                        'Forgot password?',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: hp(3)),
                    GestureDetector(
                      onTap: () async {
                        ref
                        .read(loginFormProvider.notifier)
                        .reset();

                        Navigator.pushNamed(context, '/biometrics');
                      },
                      child: Text(
                        'Log in with Biometrics',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends ConsumerWidget {
  const _GradientButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginFormProvider);

    return GradientButton(
      child: state.stage == LoginFormStage.formFilled && state.isLoginClicked
          ? CircularProgressIndicator(color: AppColors.onPrimary)
          : Text(
          'Login',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20  ,
          )
      ),
      onPressed: () async {
        ref.read(loginFormProvider.notifier).markButtonClicked();

        // simulate flow after correct login credentials to show 2FA screen
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, '/2fa');
        ref.read(loginFormProvider.notifier).reset();
      },
    );
  }
}