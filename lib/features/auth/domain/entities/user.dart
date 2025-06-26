import 'package:equatable/equatable.dart';

/// The domain‐level representation of an authenticated user.
class User extends Equatable {
  /// Unique numeric ID
  final int id;

  /// First name
  final String firstName;

  /// Surname / last name
  final String surname;

  /// Full name (first + surname)
  final String fullName;

  /// Role name (e.g. “Super Admin”)
  final String role;

  /// Email address
  final String email;

  /// Phone number
  final String phone;

  /// User type (e.g. “slts”)
  final String userType;

  /// Role ID
  final int roleId;

  /// Status (e.g. “active”)
  final String status;

  /// Last login timestamp
  final DateTime lastLogin;

  /// Login type (e.g. “admin”)
  final String loginType;

  /// Permissions granted
  final List<String> permissions;

  /// JWT or API token string
  final String token;

  const User({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.fullName,
    required this.role,
    required this.email,
    required this.phone,
    required this.userType,
    required this.roleId,
    required this.status,
    required this.lastLogin,
    required this.loginType,
    required this.permissions,
    required this.token,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    surname,
    fullName,
    role,
    email,
    phone,
    userType,
    roleId,
    status,
    lastLogin,
    loginType,
    permissions,
    token,
  ];
}
