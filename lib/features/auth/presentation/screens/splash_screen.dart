import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';



// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // TODO: Replace with your splash design
//       body: Center(child: Text('Splash Screen')),
//     );
//   }
// }


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.wp(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(AppAssets.appLogo),
                size: wp(40),
                color: AppColors.primary,
              )
              // ...other buttons...
            ],
          ),
        ),
      ),
    );
  }
}