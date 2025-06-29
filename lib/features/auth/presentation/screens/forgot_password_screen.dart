import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';

import '../../../../ui/utils/app_assets.dart';

// import '../providers/auth_notifier.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

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
                    Text(
                      'Forgot password!',
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
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
                          // prefixIcon: Icon(Icons.email),
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
                              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: hp(4)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: wp(4)),

                        decoration: BoxDecoration(
                          // color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(wp(2)),
                          border: Border.all(
                            color: AppColors.onBackgroundSurface2,
                            width: 1.5,
                          )
                        ),
                        child: Center(
                          child: Text(
                            'Send Link',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.onBackgroundSurface2,
                              fontWeight: FontWeight.bold,
                              fontSize: 20  ,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: hp(4)),
                    Text(
                        'Didn\'t receive any link? Resend link',
                        style: Theme.of(context).textTheme.labelLarge
                    ),
                    SizedBox(height: hp(2)),
                    Text(
                        'Remember password? Login',
                        style: Theme.of(context).textTheme.labelLarge
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
