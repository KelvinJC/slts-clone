import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

/// A semi‐transparent overlay header with a circular back button and title.
class OverlayHeader extends StatelessWidget {
  /// The text to show as the title.
  final String title;

  /// Called when the back button is tapped.
  final VoidCallback onBack;

  /// Optional top padding (default = 2% of height).
  final double topPadding;

  /// Height of the header bar (default = 6% of height).
  final double height;

  /// Horizontal inset before the back button (default = 4% of width).
  final double horizontalInset;

  /// Whether to show the search bar (default = false).
  final bool isSearchVisible;

  const OverlayHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.topPadding = 2,
    this.height = 6,
    this.horizontalInset = 4,
    this.isSearchVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return Padding(
      padding: EdgeInsets.only(top: hp(topPadding)),
      child: Container(
        height: hp(height),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(width: wp(horizontalInset)),
            Container(
              height: wp(11),
              width: wp(11),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
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
            SizedBox(width: wp(3)),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: wp(4.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Visibility(
              visible: isSearchVisible,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: wp(11),
                      width: wp(11),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                      ),
                      child: IconButton(
                        icon: ImageIcon(
                          const AssetImage(AppAssets.search),
                          size: wp(4.5),
                          color: AppColors.onBackground,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/search'),
                        tooltip: MaterialLocalizations.of(
                          context,
                        ).searchFieldLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: wp(horizontalInset)),
          ],
        ),
      ),
    );
  }
}
