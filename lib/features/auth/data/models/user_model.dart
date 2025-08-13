import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/core/models/permission_model.dart';
import 'package:slts_enforcer_app/core/models/token_model.dart';
import 'package:slts_enforcer_app/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'first_name')
  final String firstName;

  final String surname;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'role_name')
  final String roleName;

  @JsonKey(name: 'email_address')
  final String emailAddress;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'user_type')
  final String userType;

  @JsonKey(name: 'role_id')
  final int roleId;

  final String status;

  @JsonKey(name: 'last_login')
  final DateTime lastLogin;

  @JsonKey(name: 'login_type')
  final String loginType;

  /// Permissions array
  @JsonKey(name: 'perm')
  final List<PermissionModel> permissions;

  /// Token object containing headers map
  final TokenModel token;

  /// is2faEnabled
  final bool is2faEnabled;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.surname,
    required this.fullName,
    required this.roleName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.userType,
    required this.roleId,
    required this.status,
    required this.lastLogin,
    required this.loginType,
    required this.permissions,
    required this.token,
    this.is2faEnabled = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert to your domain entity
  User toEntity() => User(
    id: userId,
    firstName: firstName,
    surname: surname,
    fullName: fullName,
    role: roleName,
    email: emailAddress,
    phone: phoneNumber,
    userType: userType,
    roleId: roleId,
    status: status,
    lastLogin: lastLogin,
    loginType: loginType,
    permissions: permissions.map((p) => p.permission).toList(),
    token: token.headers['SLTSTrafficAPIToken']!,
    is2faEnabled: is2faEnabled,
  );
}
