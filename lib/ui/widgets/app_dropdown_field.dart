import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

typedef OnDropdownChanged<T> = void Function(T? value);

/// A custom reusable dropdown field used across the app,
/// matching the style of [AppTextField].
class AppDropdownField<T> extends StatelessWidget {
  /// The currently selected value.
  final T? value;

  /// The list of items to show in the dropdown.
  final List<DropdownMenuItem<T>> items;

  /// Called when the user selects a new value.
  final OnDropdownChanged<T>? onChanged;

  /// Placeholder shown when no value is selected.
  final String hintText;

  /// Whether the field is enabled.
  final bool enabled;

  /// Color for the enabled border.
  final Color? enabledBorderColor;

  /// If true, validates that a non-null value is selected; shows error border when null.
  final bool validateBorder;

  const AppDropdownField({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.enabled = true,
    this.enabledBorderColor,
    this.validateBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    // Determine border color
    final borderColor = !validateBorder
        ? AppColors.onBackgroundSurface2
        : ((value == null && enabled)
              ? AppColors.error
              : enabledBorderColor ?? AppColors.primary);

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
        contentPadding: EdgeInsets.symmetric(
          vertical: hp(1.2),
          horizontal: wp(3),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
      ),
      style: TextStyle(color: AppColors.onBackground, fontSize: wp(3.8)),
      icon: Padding(
        padding: EdgeInsets.only(right: wp(1.2)),
        child: ImageIcon(
          AssetImage(AppAssets.arrowDown),
          color: AppColors.onBackgroundSurface2,
          size: wp(3.5),
        ),
      ),
    );
  }
}
