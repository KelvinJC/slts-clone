import 'package:equatable/equatable.dart';

/// The domain-level representation of a violation event.
class Violation extends Equatable {
  /// PCN number description
  final String pcnNumber;

  /// Plate number description
  final String plateNumber;

  /// Offence description
  final String offence;

  /// Zone where the violation occurred
  final String zone;

  /// Date and time of the violation
  final DateTime date;

  /// First name of the violator
  final String firstName;

  /// Surname of the violator
  final String surname;

  const Violation({
    required this.pcnNumber,
    required this.plateNumber,
    required this.offence,
    required this.zone,
    required this.date,
    required this.firstName,
    required this.surname,
  });

  @override
  List<Object?> get props => [
    pcnNumber,
    plateNumber,
    offence,
    zone,
    date,
    firstName,
    surname,
  ];
}
