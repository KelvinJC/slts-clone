import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

/// A semi-transparent overlay bar with a circular back button and a title.
class OverlayAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final double opacity;
  final Color backgroundColor;

  const OverlayAppBar({
    super.key,
    required this.title,
    required this.onBack,
    this.opacity = 0.5,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Container(
      padding: EdgeInsets.only(left: wp(2), top: hp(2), bottom: hp(1)),
      // ignore: deprecated_member_use
      color: backgroundColor.withOpacity(opacity),
      child: Row(
        children: [
          // circular back button
          Container(
            height: wp(11),
            width: wp(11),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.onBackground,
                size: wp(7),
              ),
              onPressed: onBack,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            ),
          ),

          SizedBox(width: wp(5)),

          // title text
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: wp(4.5),
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
