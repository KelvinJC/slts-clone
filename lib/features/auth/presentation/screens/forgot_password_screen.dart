import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/forgot_pwd_notifier.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _State();
}

class _State extends ConsumerState<ForgotPasswordScreen> {
  var validateEmailBorder = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPwdNotifierProvider);
    final notifier = ref.read(forgotPwdNotifierProvider.notifier);
    final wp = context.wp;
    final hp = context.hp;

    return Scaffold(
      body: Stack(
        children: [
          // 1) Backdrop + form
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: hp(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: wp(10),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(wp(2)),
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: wp(3)),
                  Text(
                    'Forgot password',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                    ),
                  ),

                  SizedBox(height: hp(1)),
                  Text(
                    'Enter the email address linked to your account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onBackgroundSurface,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(height: hp(3)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                    child: AppTextField(
                      verticalPadding: 1.8,
                      initialValue: state.email,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) {
                        if (!validateEmailBorder) {
                          validateEmailBorder = true;
                        }
                        notifier.updateEmail(v);
                      },
                      validateBorder: validateEmailBorder,
                      isValid: state.emailValid,
                    ),
                  ),

                  SizedBox(height: hp(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(5)),
                    child: GradientButton(
                      isGradient: state.emailValid,
                      isLoading: state.loading,
                      onPressed: () => state.emailValid && !state.loading
                          ? notifier.sendLink()
                          : null,
                      child: state.loading
                          ? SizedBox(
                              width: wp(6),
                              height: wp(6),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Send Link',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: state.emailValid
                                        ? AppColors.onPrimary
                                        : AppColors.onBackgroundSurface2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: wp(4.5),
                                  ),
                            ),
                    ),
                  ),

                  if (state.errorMessage != null) ...[
                    SizedBox(height: hp(2)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: hp(4)),
                  GestureDetector(
                    onTap: () {
                      notifier.reset();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to login',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2) Overlay when linkSent
          if (state.linkSent)
            Container(
              color: AppColors.grayOverlay,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: wp(5),
                    vertical: hp(20),
                  ),
                  padding: EdgeInsets.all(wp(5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(wp(3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // close
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => notifier.reset(),
                          child: Icon(
                            Icons.close,
                            size: wp(6),
                            color: AppColors.onBackground,
                          ),
                        ),
                      ),

                      SizedBox(height: hp(3)),
                      Image.asset(
                        AppAssets.passwordResetEmail,
                        fit: BoxFit.cover,
                        // width: wp(24),
                        height: hp(20),
                      ),

                      SizedBox(height: hp(2)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(3)),
                        child: Text(
                          'A reset link has been sent to\n'
                          '${state.email.replaceAllMapped(RegExp(r'(^.{3})(.*?)(.{2})@'), (m) => '${m[1]}***${m[3]}@')}. '
                          'Click the link to reset your password.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.onSurface),
                        ),
                      ),
                      SizedBox(height: hp(2)),

                      // SizedBox(height: hp(3)),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     notifier.reset();
                      //     Navigator.pop(context);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsets.symmetric(
                      //       vertical: hp(2),
                      //       horizontal: wp(8),
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(wp(2)),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'Back to Login',
                      //     style: TextStyle(fontSize: wp(4)),
                      //   ),
                      // ),
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
