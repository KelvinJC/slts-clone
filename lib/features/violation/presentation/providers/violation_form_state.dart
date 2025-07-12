/// Simple id/name pair for dropdowns
class DropdownOption {
  final int id;
  final String name;
  const DropdownOption(this.id, this.name);

  /// JSON → model
  factory DropdownOption.fromJson(Map<String, dynamic> json) {
    return DropdownOption(json['id'] as int, json['name'] as String);
  }

  /// model → JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DropdownOption && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'DropdownOption(id: $id, name: $name)';
}

/// Holds the in‑progress form data.
class ViolationFormState {
  final bool isCommandLoading;

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
  }) {
    return ViolationFormState(
      offence: offence ?? this.offence,
      eventType: eventType ?? this.eventType,
      date: date ?? this.date,
      zone: zone ?? this.zone,
      command: command ?? this.command,
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      plate: plate ?? this.plate,
      plateType: plateType ?? this.plateType,
      plateColor: plateColor ?? this.plateColor,
      brand: brand ?? this.brand,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleColor: vehicleColor ?? this.vehicleColor,
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
    );
  }
}
