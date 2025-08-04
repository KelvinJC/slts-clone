import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class LoadingPopupWidget extends StatelessWidget {
  const LoadingPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp, hp = context.hp;

    return Container(
      color: AppColors.grayOverlay,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(20)),
          padding: EdgeInsets.all(wp(5)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(wp(3)),
          ),
          child: SizedBox(
            width: wp(6),
            height: wp(6),
            child: const CircularProgressIndicator(
              // color: AppColors.onPrimary,
              strokeWidth: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
