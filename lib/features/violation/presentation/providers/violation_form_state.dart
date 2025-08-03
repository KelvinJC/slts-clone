import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/features/violation/data/models/violation_hive_model.dart';

/// Simple id/name pair for dropdowns
class DropdownOption {
  final int id;
  final String name;
  final double? amount;
  const DropdownOption(this.id, this.name, this.amount);

  /// JSON → model
  factory DropdownOption.fromJson(Map<String, dynamic> json) {
    final amountValue = json['amount'];
    double? amount;

    if (amountValue is int) {
      amount = amountValue.toDouble();
    } else if (amountValue is double) {
      amount = amountValue;
    } else {
      amount = null;
    }

    return DropdownOption(json['id'] as int, json['name'] as String, amount);
  }

  /// model → JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'amount': amount};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DropdownOption && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'DropdownOption(id: $id, name: $name, amount: $amount)';

  static empty() => const DropdownOption(0, '', null);
}

/// Holds the in‑progress form data.
class ViolationFormState {
  final Failure? error;
  final bool loading;
  final ViolationHiveModel? violationModel;
  final bool isCommandLoading;
  final bool plateNoLoading;

  // — text fields
  final DropdownOption? offence;
  // final int? offenceId;
  final DropdownOption? eventType;
  // final int? eventTypeId;
  final String date;
  final DropdownOption? zone;
  // final int? zoneId;
  final DropdownOption? command;
  // final int? commandId;
  final String firstName;
  final String surname;
  final String phone;
  final String email;
  final String? offenderId;
  final String plate;
  final DropdownOption? plateType;
  // final String? plateTypeId;
  final DropdownOption? plateColor;
  // final String? plateColorId;
  final DropdownOption? brand;
  // final String? brandId;
  final DropdownOption? vehicleType;
  // final String? vehicleTypeId;
  final DropdownOption? vehicleColor;
  // final String? vehicleColorId;

  // — uploaded media paths
  final List<String> mediaPaths;

  // — the options lists we fetch once
  final List<DropdownOption> offenceOptions;
  final List<DropdownOption> eventTypeOptions;
  final List<DropdownOption> zoneOptions;
  final List<DropdownOption> commandOptions;
  final List<DropdownOption> vehicleBrandOptions;
  final List<DropdownOption> vehicleColorOptions;
  final List<DropdownOption> vehicleTypeOptions;
  final List<DropdownOption> plateColorOptions;
  final List<DropdownOption> plateTypeOptions;

  const ViolationFormState({
    this.offence,
    this.eventType,
    this.date = '',
    this.zone,
    this.command,
    this.firstName = '',
    this.surname = '',
    this.phone = '',
    this.email = '',
    this.offenderId,
    this.plate = '',
    this.plateType,
    this.plateColor,
    this.brand,
    this.vehicleType,
    this.vehicleColor,
    this.mediaPaths = const [],
    this.offenceOptions = const [],
    this.eventTypeOptions = const [],
    this.zoneOptions = const [],
    this.commandOptions = const [],
    this.vehicleBrandOptions = const [],
    this.vehicleColorOptions = const [],
    this.vehicleTypeOptions = const [],
    this.plateColorOptions = const [],
    this.plateTypeOptions = const [],
    this.isCommandLoading = false,
    this.plateNoLoading = false,
    this.error,
    this.loading = false,
    this.violationModel,
  });

  /// initial empty state
  factory ViolationFormState.initial() => const ViolationFormState();

  ViolationFormState copyWith({
    DropdownOption? offence,
    DropdownOption? eventType,
    String? date,
    DropdownOption? zone,
    DropdownOption? command,
    String? firstName,
    String? surname,
    String? phone,
    String? email,
    String? offenderId,
    String? plate,
    DropdownOption? plateType,
    DropdownOption? plateColor,
    DropdownOption? brand,
    DropdownOption? vehicleType,
    DropdownOption? vehicleColor,
    List<String>? mediaPaths,
    List<DropdownOption>? offenceOptions,
    List<DropdownOption>? eventTypeOptions,
    List<DropdownOption>? zoneOptions,
    List<DropdownOption>? commandOptions,
    List<DropdownOption>? vehicleBrandOptions,
    List<DropdownOption>? vehicleColorOptions,
    List<DropdownOption>? vehicleTypeOptions,
    List<DropdownOption>? plateColorOptions,
    List<DropdownOption>? plateTypeOptions,
    bool? isCommandLoading,
    bool? plateNoLoading,
    Failure? error,
    bool? loading,
    ViolationHiveModel? violationModel,
  }) {
    return ViolationFormState(
      offence: offence?.name == '' || offence?.id == 0
          ? null
          : offence ?? this.offence,
      eventType: eventType?.name == '' || eventType?.id == 0
          ? null
          : eventType ?? this.eventType,
      date: date ?? this.date,
      zone: zone?.name == '' || zone?.id == 0 ? null : zone ?? this.zone,
      command: command?.name == '' || command?.id == 0
          ? null
          : command ?? this.command,
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      offenderId: offenderId == '' ? null : offenderId ?? this.offenderId,
      plate: plate ?? this.plate,
      plateType: plateType?.name == '' || plateType?.id == 0
          ? null
          : plateType ?? this.plateType,
      plateColor: plateColor?.name == '' || plateColor?.id == 0
          ? null
          : plateColor ?? this.plateColor,
      brand: brand?.name == '' || brand?.id == 0 ? null : brand ?? this.brand,
      vehicleType: vehicleType?.name == '' || vehicleType?.id == 0
          ? null
          : vehicleType ?? this.vehicleType,
      vehicleColor: vehicleColor?.name == '' || vehicleColor?.id == 0
          ? null
          : vehicleColor ?? this.vehicleColor,
      mediaPaths: mediaPaths ?? this.mediaPaths,
      offenceOptions: offenceOptions ?? this.offenceOptions,
      eventTypeOptions: eventTypeOptions ?? this.eventTypeOptions,
      zoneOptions: zoneOptions ?? this.zoneOptions,
      commandOptions: commandOptions ?? this.commandOptions,
      vehicleBrandOptions: vehicleBrandOptions ?? this.vehicleBrandOptions,
      vehicleColorOptions: vehicleColorOptions ?? this.vehicleColorOptions,
      vehicleTypeOptions: vehicleTypeOptions ?? this.vehicleTypeOptions,
      plateColorOptions: plateColorOptions ?? this.plateColorOptions,
      plateTypeOptions: plateTypeOptions ?? this.plateTypeOptions,
      isCommandLoading: isCommandLoading ?? this.isCommandLoading,
      plateNoLoading: plateNoLoading == true
          ? true
          : (loading == false ? false : plateNoLoading ?? this.plateNoLoading),
      // error: error ?? this.error,
      error: error,
      loading: loading ?? this.loading,
      violationModel: violationModel ?? this.violationModel,
    );
  }
}
