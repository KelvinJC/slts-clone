import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/payment_selection_notifier.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/blank_button_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';


class AddPaymentCardScreen extends ConsumerWidget {
  const AddPaymentCardScreen({super.key});

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
                                spacing: hp(34),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: hp(15), left: wp(5), right: wp(5)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: hp(2),
                                      children: [
                                        Text(
                                          'Provide the details below',
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Cardholder Name',
                                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                // fontWeight: FontWeight.bold,
                                                  fontSize: 12
                                              ),
                                            ),
                                            SizedBox(
                                              height: hp(6),
                                              child: TextFormField(
                                                onChanged: (String val) {},
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  hintText: 'Oyewumi Olukunle',
                                                  hintStyle: TextStyle(
                                                    color: AppColors.onBackgroundSurface2,
                                                  ),
                                                  filled: true,
                                                  fillColor: Theme.of(context).colorScheme.surface,
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
                                            ),
                                            SizedBox(height: hp(1)),
                                            Text(
                                              'Card Number',
                                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                  fontSize: 12
                                              ),
                                            ),
                                            SizedBox(
                                              height: hp(6),
                                              child: TextFormField(
                                                onChanged: (val) {},
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: '4024  0071  7677  8545',
                                                  hintStyle: TextStyle(
                                                    color: AppColors.onBackgroundSurface2,
                                                  ),
                                                  filled: true,
                                                  fillColor: Theme.of(context).colorScheme.surface,
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
                                                  CreditCardNumberInputFormatter(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: hp(1)),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              spacing: wp(10),
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Expiry Date',
                                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                            fontSize: 12
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: hp(6),
                                                        child: TextFormField(
                                                          onChanged: (String val) {},
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            hintText: '02/25',
                                                            hintStyle: TextStyle(
                                                              color: AppColors.onBackgroundSurface2,
                                                            ),
                                                            filled: true,
                                                            fillColor: Theme.of(context).colorScheme.surface,
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
                                                            CreditCardExpirationDateFormatter(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child:
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'CVV',
                                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: hp(6),
                                                        child: TextFormField(
                                                          onChanged: (String val) {},
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            hintText: '777',
                                                            hintStyle: TextStyle(
                                                              color: AppColors.onBackgroundSurface2,
                                                            ),
                                                            filled: true,
                                                            fillColor: Theme.of(context).colorScheme.surface,
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
                                                            LengthLimitingTextInputFormatter(3),
                                                            // Add your custom formatter to auto-insert spaces if needed
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OverlayHeader(
                          title: 'Add Card',
                          onBack: () {
                            ref.watch(paymentSelectionProvider.notifier).clear();
                            Navigator.pop(context);
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
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
                                        'Save',
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
                          ),
                        )
                      ]
                  )
              )
            ]
        )
    );
  }
}