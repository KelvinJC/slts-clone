import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/injection.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _State();
}

class _State extends ConsumerState<LoginScreen> {
  var validateEmailBorder = false, validatePasswordBorder = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    final ctrl = ref.read(authNotifierProvider.notifier);
    final wp = context.wp;
    final hp = context.hp;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: hp(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: wp(10),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(wp(3)),
                      child: Image.asset(AppAssets.appLogo),
                    ),
                  ),
                  SizedBox(height: hp(2)),
                  Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: wp(5),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: hp(1)),
                  Text(
                    'Please sign in to continue',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: wp(3.5),
                      color: AppColors.onBackgroundSurface,
                    ),
                  ),

                  // Email field
                  SizedBox(height: hp(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                    child: AppTextField(
                      verticalPadding: 1.8,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      initialValue: auth.email,
                      onChanged: (v) {
                        if (!validateEmailBorder) {
                          validateEmailBorder = true;
                        }
                        ctrl.updateEmail(v);
                      },
                      validateBorder: validateEmailBorder,
                      isValid: auth.emailValid,
                    ),
                  ),
                  if (validateEmailBorder && !auth.emailValid)
                    Padding(
                      padding: EdgeInsets.only(
                        top: hp(1),
                        left: wp(5),
                        right: wp(5),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Enter a valid email',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: wp(3),
                          ),
                        ),
                      ),
                    ),

                  // Password field
                  SizedBox(height: hp(2)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                    child: AppTextField(
                      verticalPadding: 1.8,
                      hintText: 'Password',
                      obscureText: auth.obscureText,
                      initialValue: auth.password,
                      onChanged: (v) {
                        if (!validatePasswordBorder) {
                          validatePasswordBorder = true;
                        }
                        ctrl.updatePassword(v);
                      },
                      suffix: GestureDetector(
                        onTap: ctrl.togglePasswordVisibility,
                        child: Icon(
                          auth.obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.onBackgroundSurface2,
                          size: wp(6),
                        ),
                      ),
                      validateBorder: validatePasswordBorder,
                      isValid: auth.passwordFilled,
                    ),
                  ),
                  if (validatePasswordBorder && !auth.passwordFilled)
                    Padding(
                      padding: EdgeInsets.only(
                        top: hp(1),
                        left: wp(5),
                        right: wp(5),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password cannot be empty',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: wp(3),
                          ),
                        ),
                      ),
                    ),

                  // API error
                  if (auth.error != null)
                    Padding(
                      padding: EdgeInsets.only(
                        top: hp(2),
                        left: wp(5),
                        right: wp(5),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          auth.error!.displayMessage,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: wp(3.5),
                          ),
                        ),
                      ),
                    ),

                  // Login button
                  SizedBox(height: hp(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                    child: GradientButton(
                      isLoading: auth.loading,
                      isGradient: auth.emailValid && auth.passwordFilled,
                      onPressed: () =>
                          auth.emailValid &&
                              auth.passwordFilled &&
                              !auth.loading
                          ? ctrl.submitCredentials()
                          : null,
                      child: auth.loading
                          ? SizedBox(
                              width: wp(6),
                              height: wp(6),
                              child: const CircularProgressIndicator(
                                color: AppColors.onPrimary,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Login',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color:
                                        auth.emailValid && auth.passwordFilled
                                        ? AppColors.onPrimary
                                        : AppColors.onBackgroundSurface2,
                                    fontSize: wp(4.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                    ),
                  ),

                  // Extras
                  SizedBox(height: hp(3)),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forgotPassword'),
                    child: Text('Forgot password?'),
                  ),
                  FutureBuilder<bool>(
                    future: ref.read(biometricProvider).canCheckBiometrics,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(); // show nothing or a loader
                      }

                      if (snapshot.hasData && snapshot.data == true) {
                        return TextButton(
                          onPressed: () {
                            ref
                                .read(authNotifierProvider.notifier)
                                .loginWithBiometrics();
                          },
                          child: Text('Log in with Biometrics'),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
