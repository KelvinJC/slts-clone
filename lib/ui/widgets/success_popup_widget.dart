import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class SuccessPopupWidget extends StatelessWidget {
  final VoidCallback onClose;
  final String message;

  const SuccessPopupWidget({
    super.key,
    required this.onClose,
    this.message = 'Action completed successfully.',
  });

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
          child: Stack(
            alignment: Alignment.center,
            children: [
              // GIF background
              Positioned.fill(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    AppAssets
                        .successBgGif, // Make sure this is a looping GIF asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: onClose,
                      child: Icon(
                        Icons.close,
                        size: wp(6),
                        color: AppColors.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: hp(2)),

                  // Checkmark Icon (foreground)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: hp(3)),
                    child: Image.asset(
                      AppAssets.tick,
                      width: wp(20),
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: hp(1)),

                  // Success message
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onBackground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: hp(1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
