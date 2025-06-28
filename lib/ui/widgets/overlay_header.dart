// lib/ui/widgets/overlay_header.dart

import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

/// A flexible, semi‑transparent header bar with:
///  • a circular back button
///  • a title
///  • optionally, a search icon on the right
///
/// All sizing & padding is responsive via [SizeConfig] extensions.
class OverlayHeader extends StatelessWidget {
  /// The text to show as the title.
  final String title;

  /// Called when the back button is tapped.
  final VoidCallback onBack;

  /// If true, shows a search icon on the right.
  final bool showSearchIcon;

  /// Called when the search icon is tapped.
  final VoidCallback? onSearchTap;

  /// The background color of the bar (default white).
  final Color backgroundColor;

  /// The background color of the back button icon (default white).
  final Color backIconBackgroundColor;

  /// The opacity of [backgroundColor] (0.0–1.0).
  final double opacity;

  /// Top padding as % of screen height (default 2%).
  final double topPadding;

  /// Total height as % of screen height (default 12%).
  final double height;

  /// Horizontal inset before back & after search as % of screen width.
  final double horizontalInset;

  const OverlayHeader({
    Key? key,
    required this.title,
    required this.onBack,
    this.showSearchIcon = false,
    this.onSearchTap,
    this.backgroundColor = Colors.white,
    this.backIconBackgroundColor = Colors.white,
    this.opacity = 0.5,
    this.topPadding = 6,
    this.height = 12.5,
    this.horizontalInset = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Container(
      height: hp(height),
      padding: EdgeInsets.only(
        left: wp(horizontalInset),
        right: wp(horizontalInset),
        top: hp(topPadding),
      ),
      width: double.infinity,
      alignment: Alignment.topLeft,
      // ignore: deprecated_member_use
      color: backgroundColor.withOpacity(opacity),
      child: Row(
        children: [
          // Back button
          Container(
            height: wp(11),
            width: wp(11),
            decoration: BoxDecoration(
              color: backIconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: wp(7),
                color: AppColors.onBackground,
              ),
              onPressed: onBack,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            ),
          ),

          SizedBox(width: wp(3)),

          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: wp(4.2),
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),

          // Optional search icon
          if (showSearchIcon) ...[
            Spacer(),
            Container(
              height: wp(11),
              width: wp(11),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: ImageIcon(
                  const AssetImage(AppAssets.search),
                  size: wp(4.5),
                  color: AppColors.onBackground,
                ),
                onPressed:
                    onSearchTap ??
                    () => Navigator.pushNamed(context, '/search'),
                tooltip: MaterialLocalizations.of(context).searchFieldLabel,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
