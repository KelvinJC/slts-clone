import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import '../providers/fingerprint_auth_notifier.dart';
import '../widgets/app_logo_avatar.dart';
// import '../providers/auth_notifier.dart';

class FingerprintLoginScreen extends ConsumerWidget {
  const FingerprintLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerprintAuthState = ref.watch(biometricAuthProvider);
    final fingerprintAuthNotifier = ref.read(biometricAuthProvider.notifier);
    final hp = context.hp;
    final wp = context.wp;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: hp(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppLogoAvatar(),
                      SizedBox(height: wp(3)),
                      Text(
                        'Welcome back!',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 23
                        ),
                      ),
                      SizedBox(height: hp(1)),
                      Text(
                        'Please sign in to continue',
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
                      SizedBox(height: hp(2)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
                              // prefixIcon: Icon(Icons.key),
                              suffixIcon: GestureDetector(

                                child: Icon(
                                    color: Colors.grey,
                                    Icons.visibility
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
                                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: hp(4)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: wp(3)),
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
                              'Login',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.onBackgroundSurface2,
                                fontWeight: FontWeight.bold,
                                fontSize: 20  ,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: hp(4)),
                      // Text(
                      //     'Forgot password?',
                      //     style: Theme.of(context).textTheme.labelLarge
                      // ),
                      // SizedBox(height: hp(2)),
                      // Text(
                      //     'Log in with Biometrics',
                      //     style: Theme.of(context).textTheme.labelLarge
                      // ),
                      // SizedBox(height: hp(2)),
                    ],
                  ),
              ),
              Container(
                width: wp(100),
                height: hp(100),
                color: AppColors.grayOverlay,
              ),

                Padding(
                  padding: EdgeInsets.fromLTRB(wp(5), hp(60), wp(5), hp(9)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: wp(4)),

                    decoration: BoxDecoration(
                        color: AppColors.onPrimary,
                        borderRadius: BorderRadius.circular(wp(5)),
                        border: Border.all(
                          color: AppColors.onBackgroundSurface2,
                          width: 0.5,
                        )
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Log in with biometrics',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.onBackgroundSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: hp(2)),
                          Text(
                            'Touch the fingerprint sensor.',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.onBackgroundSurface,
                                fontSize: 13
                            ),
                          ),
                          SizedBox(height: hp(2)),
                          GestureDetector(
                            onTap: () async {
                              await fingerprintAuthNotifier.authenticate(biometricOnly: true);
                              // go back to login screen if biometric auth is successful
                              if (fingerprintAuthState.authorized == 'Authorized') {
                                Navigator.pop(context);
                              }
                            },
                            child: Icon(
                                color: AppColors.onBackgroundSurface,
                                size: 90.0,
                                Icons.fingerprint
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: wp(68), top: hp(0.8)),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}
