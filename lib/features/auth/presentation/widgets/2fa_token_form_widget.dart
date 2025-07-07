import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import '../providers/2fa_token_form_notifier.dart';
import 'blank_button_widget.dart';

class TwoFactorAuthForm extends ConsumerWidget {
  const TwoFactorAuthForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinController = ref.watch(pinControllerProvider);
    final focusNode = ref.watch(focusNodeProvider);
    final formKey = ref.watch(formKeyProvider);
    final buttonState = ref.watch(buttonStateProvider);

    final hp = context.hp;
    final wp = context.wp;

    // placeholder value to simulate correct entry of 2FA token
    // TODO: replace with actual 2FA token
    final expected = '222222';

    final defaultPinTheme = PinTheme(
      width: wp(13),
      height: hp(6.5),
      textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontSize: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(wp(2)),
        border: Border.all(
            color: AppColors.onBackgroundSurface2,
            width: wp(0.4)
        ),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: expected.length,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => SizedBox(width: wp(1.6)),
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              validator: (value) => value == expected ? null : 'Pin is incorrect',
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                if (pin == expected) {
                  ref.read(buttonStateProvider.notifier).setBtnColorToGradient();
                }
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                if (value == expected) {
                  ref.read(buttonStateProvider.notifier).setBtnColorToGradient();
                }
                else {
                  ref.read(buttonStateProvider.notifier).clear();
                }
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: hp(1)),
                    width: wp(6),
                    height: hp(0.2),
                    color: AppColors.secondary,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(wp(2)),
                  border: Border.all(
                      color: AppColors.primary ,
                      width: wp(0.4)
                  ),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(wp(2)),
                  border: Border.all(
                      color: AppColors.secondary,
                      width: wp(0.4)
                  ),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: AppColors.error),
              ),
            ),
          ),
          SizedBox(height: hp(6)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wp(5)),
            child: [ButtonStage.gradient, ButtonStage.clicked].contains(buttonState)
                ? const _GradientButton()
                : const BlankButton(text: 'Continue'),
          )
        ],
      ),
    );
  }
}

class _GradientButton extends ConsumerWidget {
  const _GradientButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(formKeyProvider);
    final buttonState = ref.watch(buttonStateProvider);

    return GradientButton(
      child: buttonState == ButtonStage.clicked
          ? CircularProgressIndicator(color: AppColors.onPrimary)
          : Text(
          'Continue',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20  ,
          )
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus(); // hide keyboard

        if (formKey.currentState!.validate() == true) {
          ref.read(buttonStateProvider.notifier).markButtonClicked();
          // simulate a successful 2fa authentication to show home screen
          await Future.delayed(const Duration(seconds: 1));
          Navigator.popAndPushNamed(context, '/home');
          ref.read(buttonStateProvider.notifier).clear();
        }
      },
    );
  }
}