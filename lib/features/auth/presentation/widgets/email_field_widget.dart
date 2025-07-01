import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import '../providers/login_form_notifier.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class EmailField extends ConsumerStatefulWidget {
  const EmailField({super.key});

  @override
  ConsumerState<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends ConsumerState<EmailField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // User left the field
        ref.read(loginFormProvider.notifier).markEmailTouched();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginFormProvider);
    final wp = context.wp;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (String val) {
        if (val.trim() != '') {
          ref
              .read(loginFormProvider.notifier)
              .setFieldToFilled('email', emailValue: val.trim());
        } else {
          ref.read(loginFormProvider.notifier).setFieldToUnfilled('email');
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        // labelText: 'Email',
        errorText: loginState.emailTouched && !loginState.emailValid
            ? 'Please enter a valid email'
            : null,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(wp(2)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(wp(2)),
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
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
