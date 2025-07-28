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

  /// Whether the field is for preview mode.
  final bool isPreviewMode;

  /// Color for the enabled border.
  final Color? enabledBorderColor;

  /// If true, validates that a non-null value is selected; shows error border when null.
  final bool validateBorder;

  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  /// Whether the field is currently processing.
  final bool isProcessing;

  const AppDropdownField({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.enabled = true,
    this.isPreviewMode = false,
    this.enabledBorderColor,
    this.validateBorder = false,
    this.selectedItemBuilder,
    this.isProcessing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    // Determine border color
    final borderColor = !validateBorder
        ? (isPreviewMode
              ? AppColors.onBackground
              : AppColors.onBackgroundSurface2)
        : ((value == null && enabled)
              ? AppColors.error
              : (!enabled
                    ? AppColors.onBackgroundSurface2
                    : enabledBorderColor ?? AppColors.primary));
    final previewBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
      // gapPadding: 0,
    );

    Widget dropdown = DropdownButtonFormField<T>(
      value: value,
      items: items,
      selectedItemBuilder: selectedItemBuilder,
      onChanged: (enabled && !isPreviewMode) ? onChanged : null, //(v) => {},
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        hintText: isPreviewMode ? '' : hintText,
        // focusColor: isPreviewMode ? AppColors.onBackground : null,
        hintStyle: TextStyle(
          color: isPreviewMode
              ? AppColors.onBackground
              : AppColors.onBackgroundSurface2,
        ),
        // labelStyle: TextStyle(
        //   color: isPreviewMode ? AppColors.onBackground : null,
        // ),
        contentPadding: isPreviewMode
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: hp(1.2), horizontal: wp(3)),
        filled: true,
        fillColor: isPreviewMode
            ? Colors.transparent
            : (!enabled
                  ? AppColors.surface.withOpacity(0.2)
                  : Theme.of(context).colorScheme.surface),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: isPreviewMode
            ? previewBorder
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(wp(2)),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
        focusedBorder: isPreviewMode
            ? previewBorder
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(wp(2)),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
        disabledBorder: previewBorder,
      ),
      style: TextStyle(color: AppColors.onBackground, fontSize: wp(3.8)),
      icon: isPreviewMode || !enabled
          ? SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(right: wp(1.2)),
              child: isProcessing
                  ? SizedBox(
                      height: wp(3),
                      width: wp(3),
                      child: const CircularProgressIndicator(strokeWidth: 1.5),
                    )
                  : ImageIcon(
                      AssetImage(AppAssets.arrowDown),
                      color: AppColors.onBackgroundSurface2,
                      size: wp(3.5),
                    ),
            ),
    );

    if (isPreviewMode || !enabled) {
      // Block taps (so no menu), but keep your 'enabled' look
      return AbsorbPointer(child: dropdown);
    }

    return dropdown;
  }
}
