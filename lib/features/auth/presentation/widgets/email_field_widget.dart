import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'email_field_interfaces.dart';


class EmailField<NotifierT extends EmailFieldNotifier<StateT>, StateT extends EmailFormState> extends ConsumerStatefulWidget {
  const EmailField({
    super.key,
    required this.formProvider, // Accept the provider as an argument
  });

  final StateNotifierProvider<NotifierT, StateT> formProvider;

  @override
  ConsumerState<EmailField<NotifierT, StateT>> createState() => _EmailFieldState();
}

class _EmailFieldState<NotifierT extends EmailFieldNotifier<StateT>, StateT extends EmailFormState> extends ConsumerState<EmailField<NotifierT, StateT>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // User left the field
        ref.read(widget.formProvider.notifier).markEmailFieldTouched();
      }
    });
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    _focusNode.dispose();
    print('dispose called!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(widget.formProvider);
    final wp = context.wp;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (String val) {
        if (val.trim() != '') {
          ref
              .read(widget.formProvider.notifier)
              .setFieldToFilled('email', emailValue: val.trim());
        } else {
          ref.read(widget.formProvider.notifier).setFieldToUnfilled('email');
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(color: AppColors.onBackgroundSurface2),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        // labelText: 'Email',
        errorText: loginState.emailFieldTouched && !loginState.emailValid
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
