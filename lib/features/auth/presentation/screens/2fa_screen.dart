import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/auth/presentation/widgets/2fa_token_form_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class TwoFactorAuthScreen extends StatelessWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.all(wp(2)),
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: hp(2)),
                  Text(
                    'Two‑Factor',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: wp(5),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Authentication',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: wp(5),
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: hp(1)),
                  Text(
                    'Enter the 6‑digit code sent to your email.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: wp(3.5),
                      color: AppColors.onBackgroundSurface,
                    ),
                  ),

                  SizedBox(height: hp(5)),

                  // The form itself
                  const TwoFactorAuthForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
