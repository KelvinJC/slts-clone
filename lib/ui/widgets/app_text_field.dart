import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

typedef OnTextChanged = void Function(String);
typedef OnSubmitted = void Function(String);

/// A custom reusable text field used across the app, supporting both
/// controller-based and `initialValue`-based form inputs.
class AppTextField extends StatelessWidget {
  /// Optional controller for managing text externally.
  final TextEditingController? controller;

  /// Optional initial value when using without a controller.
  final String? initialValue;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Placeholder shown inside the field.
  final String hintText;

  /// Called when the user taps the field (before focus).
  final VoidCallback? onTap;

  /// Called when the user submits (presses enter).
  final OnSubmitted? onSubmitted;

  /// If true, the field is read-only.
  final bool readOnly;

  /// Whether to show the search icon or a custom prefix.
  final bool showSearchIcon;

  /// Custom prefix widget (overrides search icon).
  final Widget? prefix;

  /// Optional suffix widget (e.g. for clear button).
  final Widget? suffix;

  /// Whether the text field is obscured (e.g. for passwords).
  final bool obscureText;

  /// Whether the field is enabled.
  final bool enabled;

  /// Max lines allowed.
  final int maxLines;

  /// Keyboard type.
  final TextInputType keyboardType;

  /// Color for the enabled border.
  final Color? enabledBorderColor;

  /// Whether to validate the border color based on the text.
  final bool validateBorder;

  /// Whether the field is for preview mode.
  final bool isPreviewMode;

  const AppTextField({
    Key? key,
    this.controller,
    this.initialValue,
    required this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.onSubmitted,
    this.readOnly = false,
    this.showSearchIcon = false,
    this.prefix,
    this.suffix,
    this.enabledBorderColor,
    this.validateBorder = false,
    this.isPreviewMode = false,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both a controller and initialValue.',
       ),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    final previewBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 0, color: Colors.transparent),
      gapPadding: 0,
    );

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onSubmitted,
      obscureText: obscureText,
      enabled: enabled || isPreviewMode,
      readOnly: readOnly || isPreviewMode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: isPreviewMode
            ? (controller != null ? controller!.text : initialValue)
            : hintText,
        hintStyle: TextStyle(
          color:
              (keyboardType == TextInputType.datetime &&
                      !hintText.toLowerCase().contains('select') ||
                  isPreviewMode)
              ? AppColors.onBackground
              : AppColors.onBackgroundSurface2,
        ),
        prefixIcon: prefix != null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: hp(1.5)),
                child: prefix,
              )
            : (showSearchIcon
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: hp(1.5)),
                      child: ImageIcon(
                        const AssetImage(AppAssets.search),
                        size: wp(6),
                        color: AppColors.onBackgroundSurface2,
                      ),
                    )
                  : null),
        suffixIcon: suffix != null && !isPreviewMode
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: hp(1.5)),
                child: suffix,
              )
            : null,
        contentPadding: isPreviewMode
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: hp(1.2), horizontal: wp(3)),
        filled: true,
        fillColor: isPreviewMode
            ? Colors.transparent
            : Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: isPreviewMode
            ? previewBorder
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(wp(2)),
                borderSide: BorderSide(
                  color: !validateBorder
                      ? AppColors.onBackgroundSurface2
                      : ((controller?.text ?? initialValue) == '' && enabled
                            ? AppColors.error
                            : enabledBorderColor ?? AppColors.primary),
                  width: 1.5,
                ),
              ),
        focusedBorder: isPreviewMode
            ? previewBorder
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(wp(2)),
                borderSide: BorderSide(
                  color: !validateBorder
                      ? AppColors.onBackgroundSurface2
                      : ((controller?.text ?? initialValue)!.isEmpty && enabled
                            ? AppColors.error
                            : enabledBorderColor ?? AppColors.primary),
                  width: 1.5,
                ),
              ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(wp(2)),
        //   borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
        // ),
      ),
      style: TextStyle(color: AppColors.onBackground, fontSize: wp(3.8)),
    );
  }
}
