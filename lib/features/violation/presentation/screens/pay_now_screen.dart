import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/payment_selection_notifier.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/blank_button_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hp = context.hp;
    final wp = context.wp;
    final paymentState = ref.watch(paymentSelectionProvider);

    return Scaffold(
        body: Stack(
            children: [
              BlurryGradientBackground(colors: AppColors.homeGradient),
              SafeArea(
                  top: false,
                  child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                spacing: hp(46.5),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: hp(15), left: wp(5), right: wp(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: hp(2),
                                      children: [
                                        Text(
                                          'Select Payment Method',
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        // SizedBox(height: wp(2)),
                                        TextFormField(
                                            onTap: () => ref.read(paymentSelectionProvider.notifier).selectPayment(PaymentSelection.mastercard),
                                            readOnly: true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: '**** **** **** 7844',
                                              hintStyle: TextStyle(
                                                color: AppColors.onBackgroundSurface2,
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).colorScheme.surface,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(
                                                  AppAssets.mastercard,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              // prefixIcon: Icon(Icons.credit_card),
                                              suffixIcon: paymentState == PaymentSelection.mastercard
                                                  ? Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Image.asset(
                                                        AppAssets.radioButton,
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    )
                                                  : Icon(
                                                      color: Colors.grey,
                                                      Icons.circle_outlined
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
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(16),
                                              // Add your custom formatter to auto-insert spaces if needed
                                            ],
                                          ),
                                        // SizedBox(height: wp(2)),
                                        TextFormField(
                                            onTap: () =>
                                                ref
                                                    .read(paymentSelectionProvider.notifier)
                                                    .selectPayment(PaymentSelection.visa),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: '**** **** **** 1366',
                                              hintStyle: TextStyle(
                                                color: AppColors.onBackgroundSurface2,
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).colorScheme.surface,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(
                                                  AppAssets.visa,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              suffixIcon: paymentState == PaymentSelection.visa
                                                ? Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Image.asset(
                                                      AppAssets.radioButton,
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  )
                                                : Icon(
                                                  color: Colors.grey,
                                                  Icons.circle_outlined
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
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(context, '/addCard'),
                                          child: Row(
                                            spacing: wp(1),
                                            children: [
                                              Icon(
                                                color: AppColors.primary,
                                                Icons.add
                                              ),
                                              Text(
                                                'Add Card',
                                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                    color: AppColors.primary,
                                                    // fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.onPrimary,
                                    height: hp(12),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: hp(2), horizontal: wp(5)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              ref.watch(paymentSelectionProvider.notifier).clear();
                                              Navigator.pop(context);
                                            },
                                            child: SizedBox(
                                              width: wp(44),
                                              child: BlankButton(text: 'Cancel'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: wp(44),
                                            child: GradientButton(
                                              onPressed: () => {},
                                              child: Text(
                                                'Pay',
                                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: AppColors.onPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ],
                          ),
                        ),
                        OverlayHeader(
                          title: 'Payment Methods',
                          onBack: () {
                              ref.watch(paymentSelectionProvider.notifier).clear();
                              Navigator.pop(context);
                            },
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }
}