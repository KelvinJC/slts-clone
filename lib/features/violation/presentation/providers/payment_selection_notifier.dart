import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentSelection { none, mastercard, visa }

final paymentSelectionProvider = StateNotifierProvider<PaymentSelectionNotifier, PaymentSelection>((ref) {
  return PaymentSelectionNotifier();
});

class PaymentSelectionNotifier extends StateNotifier<PaymentSelection> {
  PaymentSelectionNotifier() : super(PaymentSelection.none);

  void selectPayment(PaymentSelection payment) {
   print("Selection made $payment");
   state = payment;
  }

  void clear() => state = PaymentSelection.none;
}