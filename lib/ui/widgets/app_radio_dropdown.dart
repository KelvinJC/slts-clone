import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

typedef OnRadioChanged<T> = void Function(T? value);

/// A dropdown that shows its menu as a list of radio‑style items,
/// with the same pill shape, red error border, and inline error text.
class AppRadioDropdown<T> extends StatelessWidget {
  /// The currently selected value (or null).
  final T? value;

  /// The list of possible values.
  final List<T> options;

  /// A builder to render each option.
  final String Function(T) itemLabel;

  /// Called when the user selects an option.
  final OnRadioChanged<T> onChanged;

  /// Placeholder when nothing is selected.
  final String hintText;

  /// Whether to show the red “required” error style.
  final bool showError;

  const AppRadioDropdown({
    Key? key,
    required this.value,
    required this.options,
    required this.itemLabel,
    required this.onChanged,
    required this.hintText,
    this.showError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;

    // border color toggles red on error
    final borderColor = showError
        ? AppColors.error
        : AppColors.onBackgroundSurface2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            value: value,
            hint: Padding(
              padding: EdgeInsets.symmetric(vertical: hp(1)),
              child: Text(
                hintText,
                style: TextStyle(
                  color: AppColors.onBackgroundSurface2,
                  fontSize: wp(3.8),
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: context.wp(50),
              maxHeight: hp(40),
              padding: EdgeInsets.symmetric(vertical: hp(1)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(wp(2)),
                border: Border.all(color: borderColor, width: 1.5),
              ),
            ),
            buttonStyleData: ButtonStyleData(
              height: hp(6),
              padding: EdgeInsets.symmetric(horizontal: wp(4)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(wp(2)),
                border: Border.all(
                  color: !showError
                      ? AppColors.onBackgroundSurface2
                      : (value == '' ? AppColors.error : AppColors.primary),
                  width: 1.5,
                ),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: hp(6),
              padding: EdgeInsets.symmetric(horizontal: wp(4)),
              selectedMenuItemBuilder: (context, child) => Container(
                padding: EdgeInsets.symmetric(vertical: hp(1)),
                child: Row(
                  children: [Checkbox(value: true, onChanged: null), child],
                ),
              ),
            ),
            // iconStyleData: IconStyleData(
            //   icon: Icon(
            //     Icons.arrow_drop_down,
            //     color: AppColors.onBackgroundSurface2,
            //     size: wp(6),
            //   ),
            // ),
            // dropdownWidth: MediaQuery.of(context).size.width - wp(8),
            // buttonHeight: hp(6),
            // buttonPadding: EdgeInsets.symmetric(horizontal: wp(4)),
            // buttonDecoration: BoxDecoration(
            //   color: Theme.of(context).colorScheme.surface,
            //   borderRadius: BorderRadius.circular(wp(2)),
            //   border: Border.all(color: borderColor, width: 1.5),
            // ),
            // icon: Icon(
            //   Icons.arrow_drop_down,
            //   color: AppColors.onBackgroundSurface2,
            //   size: wp(6),
            // ),

            // // --- here's the custom dropdown menu styling ---
            // dropdownDecoration: BoxDecoration(
            //   color: Theme.of(context).colorScheme.surface,
            //   borderRadius: BorderRadius.circular(wp(2)),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.1),
            //       blurRadius: 8,
            //       offset: const Offset(0, 4),
            //     )
            //   ],
            // ),
            // dropdownElevation: 0,
            // dropdownPadding: EdgeInsets.zero,
            // offset: const Offset(0, 4),

            // --- build the radio‐style list ---
            items: options
                .map(
                  (opt) => DropdownMenuItem<T>(
                    value: opt,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: hp(1),
                        horizontal: wp(3),
                      ),
                      child: Row(
                        children: [
                          Radio<T>(
                            value: opt,
                            groupValue: value,
                            onChanged: onChanged,
                            activeColor: AppColors.primary,
                          ),
                          SizedBox(width: wp(2)),
                          Expanded(
                            child: Text(
                              itemLabel(opt),
                              style: TextStyle(fontSize: wp(3.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),

            // when user taps an item, call onChanged
            onChanged: onChanged,
          ),
        ),

        // inline error message
        if (showError && value == null)
          Padding(
            padding: EdgeInsets.only(top: hp(0.5), left: wp(4)),
            child: Text(
              'You are required to fill this field',
              style: TextStyle(color: AppColors.error, fontSize: wp(3.2)),
            ),
          ),
      ],
    );
  }
}
