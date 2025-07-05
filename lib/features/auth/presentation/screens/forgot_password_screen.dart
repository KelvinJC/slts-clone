import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/forgot_pwd_form_notifier.dart';
import 'package:slts_enforcer_app/features/auth/presentation/widgets/email_field_widget.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
// import '../providers/auth_notifier.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailFieldState = ref.watch(forgotPwdFormProvider);
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
                    CircleAvatar(
                      radius: wp(10),
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12), // Adjust padding to shrink the logo
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
                        fontSize: 23
                      ),
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                      'Enter the email address linked to your account',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.onBackgroundSurface,
                        fontSize: 13
                      )
                    ),
                    SizedBox(height: hp(3)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: EmailField(formProvider: forgotPwdFormProvider),
                    ),
                    SizedBox(height: hp(4)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: emailFieldState.emailValid
                      ? _buildGradientSendLinkButton(context, ref, emailFieldState)
                      : _buildBlankSendLinkButton(context, wp)
                    ),
                    SizedBox(height: hp(4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Didn\'t receive any link?',
                            style: Theme.of(context).textTheme.labelLarge
                        ),
                        SizedBox(width: wp(2)),
                        Text(
                            'Resend link',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.primary
                            )
                        )
                      ],
                    ),
                    SizedBox(height: hp(3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Remember password?',
                            style: Theme.of(context).textTheme.labelLarge
                        ),
                        SizedBox(width: wp(2)),
                        GestureDetector(
                          onTap: () async {
                            // ref
                            // .read(forgotPwdFormProvider.notifier)
                            // .reset();


                            Navigator.pop(context);
                          },
                          child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.primary
                              )
                          ),
                        )
                      ],
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

  Widget _buildGradientSendLinkButton(BuildContext ctx, WidgetRef ref, ForgotPwdFormState pwdFormState) {
    return GradientButton(
      child: pwdFormState.emailValid && pwdFormState.isSendLinkClicked
          ? CircularProgressIndicator(color: AppColors.onPrimary)
          : Text(
          'Send Link',
          style: Theme.of(ctx).textTheme.labelLarge?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20  ,
          )
      ),
      onPressed: () async {
        ref.read(forgotPwdFormProvider.notifier).markButtonClicked();

        // simulate a successful password change to show password reset link sent success screen
        await Future.delayed(const Duration(seconds: 2));
        Navigator.popAndPushNamed(ctx, '/passwordResetNotification');
      },
    );
  }

  Widget _buildBlankSendLinkButton(BuildContext ctx, double Function(double) wp) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: wp(3)),
      decoration: BoxDecoration(
        // color: Colors.grey[400],
        borderRadius: BorderRadius.circular(wp(2)),
        border: Border.all(color: AppColors.onBackgroundSurface2, width: wp(0.4)),
      ),
      child: Center(
        child: Text(
          'Send Link',
          style: Theme.of(ctx).textTheme.labelLarge?.copyWith(
            color: AppColors.onBackgroundSurface2,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
