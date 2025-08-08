import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class PopupContainer extends StatelessWidget {
  final VoidCallback onClose;
  final Widget child;

  const PopupContainer({super.key, required this.onClose, required this.child});

  @override
  Widget build(BuildContext context) {
    final wp = context.wp, hp = context.hp;

    return Container(
      color: AppColors.grayOverlay,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: wp(5)),
          padding: EdgeInsets.all(wp(5)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(wp(3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
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
              SizedBox(height: hp(5)),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
