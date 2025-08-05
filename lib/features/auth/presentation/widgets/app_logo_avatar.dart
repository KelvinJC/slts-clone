import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class AppLogoAvatar extends StatelessWidget {

  const AppLogoAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;

    return CircleAvatar(
      radius: wp(10),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
          wp(3),
        ),
        child: Image.asset(
          AppAssets.appLogo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
