import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class ErrorPopupWidget extends StatelessWidget {
  final VoidCallback onClose;
  final String? errorMessage;

  const ErrorPopupWidget({super.key, required this.onClose, this.errorMessage});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onClose,
                  child: Icon(Icons.close, size: wp(6)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: hp(3)),
                child: Image.asset(
                  AppAssets.error,
                  width: wp(20),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: hp(3)),
                padding: EdgeInsets.only(bottom: hp(2)),
                child: Text(
                  errorMessage ?? 'An unexpected error occurred.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
