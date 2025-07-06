import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class TwoFactorAuthForm extends ConsumerStatefulWidget {
  const TwoFactorAuthForm({Key? key}) : super(key: key);

  @override
  ConsumerState<TwoFactorAuthForm> createState() => _TwoFactorAuthFormState();
}

class _TwoFactorAuthFormState extends ConsumerState<TwoFactorAuthForm> {
  late final TextEditingController _pinController;
  late final FocusNode _focusNode;
  final _formKey = GlobalKey<FormState>();
  bool _buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final pin = _pinController.text.trim();
    // call verifyOtp on your AuthNotifier
    await ref.read(authNotifierProvider.notifier).verifyOtp(pin);
    // AuthState listener in main.dart will navigate when authenticated
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    final wp = context.wp;
    final hp = context.hp;

    final pinTheme = PinTheme(
      width: wp(13),
      height: hp(6.5),
      textStyle: Theme.of(
        context,
      ).textTheme.displaySmall?.copyWith(fontSize: wp(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(wp(2)),
        border: Border.all(
          color: AppColors.onBackgroundSurface2,
          width: wp(0.4),
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: _pinController,
              focusNode: _focusNode,
              defaultPinTheme: pinTheme,
              focusedPinTheme: pinTheme.copyWith(
                decoration: pinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.primary, width: wp(0.4)),
                ),
              ),
              submittedPinTheme: pinTheme.copyWith(
                decoration: pinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.primary, width: wp(0.4)),
                ),
              ),
              errorPinTheme: pinTheme.copyBorderWith(
                border: Border.all(color: AppColors.error),
              ),
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              validator: (value) {
                if (value == null || value.trim().length != 6) {
                  return 'Enter 6‑digit code';
                }
                return null;
              },
              onChanged: (value) {
                final ok = value.trim().length == 6;
                if (ok != _buttonEnabled) {
                  setState(() {
                    _buttonEnabled = ok;
                  });
                }
              },
            ),
          ),

          SizedBox(height: hp(4)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: wp(5)),
            child: GradientButton(
              isGradient: _buttonEnabled,
              onPressed: () =>
                  _buttonEnabled && !auth.loading ? _onSubmit() : null,
              child: auth.loading
                  ? SizedBox(
                      width: wp(6),
                      height: wp(6),
                      child: const CircularProgressIndicator(
                        color: AppColors.onPrimary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      'Continue',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: _buttonEnabled
                            ? AppColors.onPrimary
                            : AppColors.onBackgroundSurface2,
                        fontSize: wp(4.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),

          if (auth.error != null) ...[
            SizedBox(height: hp(2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(5)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  auth.error!.displayMessage,
                  style: TextStyle(color: AppColors.error, fontSize: wp(3.5)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
