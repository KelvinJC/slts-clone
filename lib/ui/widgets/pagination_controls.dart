import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

/// A row of page‑number buttons with “<” and “>” arrows, showing up to 3 pages at once.
class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final void Function(int newPage) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : assert(currentPage >= 1 && currentPage <= totalPages);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    Widget _buildBtn({
      required Widget child,
      required bool active,
      required bool disabled,
      required VoidCallback? onTap,
    }) {
      final decoration = active
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.buttonGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(wp(2)),
            )
          : BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(wp(2)),
              border: Border.all(color: AppColors.onBackgroundSurface2),
            );

      return GestureDetector(
        onTap: disabled ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: wp(11),
          height: hp(5),
          alignment: Alignment.center,
          decoration: decoration,
          child: child,
        ),
      );
    }

    // compute window of pages to show
    int startPage;
    if (totalPages <= 3) {
      startPage = 1;
    } else if (currentPage == 1) {
      startPage = 1;
    } else if (currentPage == totalPages) {
      startPage = totalPages - 2;
    } else {
      startPage = currentPage - 1;
    }
    final endPage = (startPage + 2).clamp(1, totalPages);

    // build page buttons
    final pageButtons = <Widget>[];
    for (int p = startPage; p <= endPage; p++) {
      final isActive = p == currentPage;
      pageButtons.add(
        _buildBtn(
          child: Text(
            p.toString(),
            style: TextStyle(
              fontSize: wp(3.5),
              fontWeight: FontWeight.bold,
              color: isActive
                  ? AppColors.surface
                  : AppColors.onBackgroundSurface2,
            ),
          ),
          active: isActive,
          disabled: false,
          onTap: () => onPageChanged(p),
        ),
      );
      if (p < endPage) pageButtons.add(SizedBox(width: wp(1)));
    }

    // previous/next
    final prev = _buildBtn(
      child: Icon(
        Icons.chevron_left,
        color: currentPage > 1
            ? AppColors.surface
            : AppColors.onBackgroundSurface2,
      ),
      active: currentPage > 1,
      disabled: currentPage == 1,
      onTap: () => onPageChanged(currentPage - 1),
    );
    final next = _buildBtn(
      child: Icon(
        Icons.chevron_right,
        color: currentPage < totalPages
            ? AppColors.surface
            : AppColors.onBackgroundSurface2,
      ),
      active: currentPage < totalPages,
      disabled: currentPage == totalPages,
      onTap: () => onPageChanged(currentPage + 1),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...pageButtons,
          SizedBox(width: wp(2)),
          prev,
          SizedBox(width: wp(2)),
          next,
        ],
      ),
    );
  }
}
