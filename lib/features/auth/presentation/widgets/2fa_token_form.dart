import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import '../providers/2fa_token_form_notifier.dart';


class TwoFactorAuthForm extends ConsumerStatefulWidget {
  const TwoFactorAuthForm({super.key});

  @override
  ConsumerState<TwoFactorAuthForm> createState() => _TwoFactorAuthFormState();
}

class _TwoFactorAuthFormState extends ConsumerState<TwoFactorAuthForm> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
    List.generate(6, (_) => TextEditingController());

  final List<String> _previousValues = List.filled(6, '');

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final ctrl in _controllers) {
      ctrl.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(twoFactorAuthProvider);
    final otpNotifier = ref.read(twoFactorAuthProvider.notifier);
    final hp = context.hp;
    final wp = context.wp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        bool hasValue = otpState[index].isNotEmpty;

        return Container(
          width: 50,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(wp(2)),
            border: Border.all(
                color: hasValue ? AppColors.primary : AppColors.onBackgroundSurface2,
                width: wp(0.4)),
          ),
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: "0",
                hintStyle: TextStyle(
                    fontSize: 18,
                    color: AppColors.onBackgroundSurface2,
                ),
            ),
              onChanged: (value) {
                if (value.length == 1 && index < 5) {
                  otpNotifier.updateDigit(index, value);
                  // otpState[index] = value;
                  FocusScope.of(context).nextFocus();
                }
                if (value.length == 1 && index == 5) {
                  otpNotifier.updateDigit(index, value);
                }
                if (value.isEmpty && index != 0) {
                  otpNotifier.updateDigit(index - 1, '');
                  otpNotifier.updateDigit(index, '');
                  FocusScope.of(context).previousFocus();
                }
             }
          ),
        );
      }),
    );
  }
}
