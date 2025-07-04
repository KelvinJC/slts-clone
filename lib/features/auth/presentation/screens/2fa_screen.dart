import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/2fa_button_notifier.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import '../providers/2fa_token_form_notifier.dart';
import '../widgets/2fa_token_form.dart';
// import '../providers/auth_notifier.dart';


class TwoFactorAuthScreen extends ConsumerWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    Column(
                      children: [
                        Text(
                          'Two-Factor',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),
                        ),
                        Text(
                          'Authentication',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                        'Enter the 2FA code linked to your account.',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onBackgroundSurface,
                            fontSize: 13
                        )
                    ),
                    SizedBox(height: hp(5)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: wp(2)),
                            child: TwoFactorAuthForm(),
                        ),
                        SizedBox(height: hp(4)),
                        Consumer(builder: (context, ref, _) {
                          final otp = ref.watch(twoFactorAuthProvider).join();
                          return  Padding(
                              padding: EdgeInsets.symmetric(horizontal: wp(5)),
                              child: otp.length == 6
                                  ? _buildGradientContinue2FAButton(context, ref, otp)
                                  : _buildBlankContinue2FAButton(context, wp)
                          );
                        })
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

  Widget _buildGradientContinue2FAButton(BuildContext ctx, WidgetRef ref, String otp) {
    return GradientButton(
      child: otp.length == 6 && ref.watch(buttonStateProvider) == true
          ? CircularProgressIndicator(color: AppColors.onPrimary)
          : Text(
          'Continue',
          style: Theme.of(ctx).textTheme.labelLarge?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20  ,
          )
      ),
      onPressed: () async {
        ref.read(buttonStateProvider.notifier).markButtonClicked();
        FocusScope.of(ctx).unfocus(); // hide keyboard

        // simulate a successful 2fa authentication to show home screen
        await Future.delayed(const Duration(seconds: 2));
        Navigator.popAndPushNamed(ctx, '/home');
        ref.read(buttonStateProvider.notifier).clear();
      },
    );
  }

  Widget _buildBlankContinue2FAButton(BuildContext ctx, double Function(double) wp) {
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
          'Continue',
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
