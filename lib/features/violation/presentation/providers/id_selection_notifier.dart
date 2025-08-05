import 'package:flutter_riverpod/flutter_riverpod.dart';

enum IdSelected { none, driversLicense, vehicleParticulars }

final idSelectionProvider = StateNotifierProvider<IdSelectionNotifier, IdSelected>((ref) {
  return IdSelectionNotifier();
});

class IdSelectionNotifier extends StateNotifier<IdSelected> {
  IdSelectionNotifier() : super(IdSelected.none);

  void selectId(IdSelected id)  => state = id;
  void clear() => state = IdSelected.none;
}
