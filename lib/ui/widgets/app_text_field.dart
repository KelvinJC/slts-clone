import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

typedef OnTextChanged = void Function(String);
typedef OnSubmitted = void Function(String);

class AppTextField extends StatelessWidget {
  /// Controller for the text input.
  final TextEditingController? controller;

  /// Placeholder text.
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

  /// Whether to obscure text (for passwords).
  final bool obscureText;

  /// Keyboard type.
  final TextInputType keyboardType;

  /// Input formatter or validator can be added later.

  const AppTextField({
    super.key,
    this.controller,
    this.hintText = 'Enter text...',
    this.onTap,
    this.onSubmitted,
    this.readOnly = false,
    this.showSearchIcon = false,
    this.prefix,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      onSubmitted: onSubmitted,
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
    );
  }
}
