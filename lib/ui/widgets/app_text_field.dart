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

  /// Whether the text field is obscured (e.g. for passwords).
  final bool obscureText;

  /// Whether the field is enabled.
  final bool enabled;

  /// Max lines allowed.
  final int maxLines;

  /// Keyboard type.
  final TextInputType keyboardType;

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
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both a controller and initialValue.',
       ),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
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
        contentPadding: EdgeInsets.symmetric(vertical: hp(1.5)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(
            color: AppColors.onBackgroundSurface2,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(wp(2)),
          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
        ),
      ),
      style: TextStyle(color: AppColors.onBackground, fontSize: wp(3.8)),
    );
  }
}
