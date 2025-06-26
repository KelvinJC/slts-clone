// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['user_id'] as num).toInt(),
      firstName: json['first_name'] as String,
      surname: json['surname'] as String,
      fullName: json['full_name'] as String,
      roleName: json['role_name'] as String,
      emailAddress: json['email_address'] as String,
      phoneNumber: json['phone_number'] as String,
      userType: json['user_type'] as String,
      roleId: (json['role_id'] as num).toInt(),
      status: json['status'] as String,
      lastLogin: DateTime.parse(json['last_login'] as String),
      loginType: json['login_type'] as String,
      permissions: (json['perm'] as List<dynamic>)
          .map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: TokenModel.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'surname': instance.surname,
      'full_name': instance.fullName,
      'role_name': instance.roleName,
      'email_address': instance.emailAddress,
      'phone_number': instance.phoneNumber,
      'user_type': instance.userType,
      'role_id': instance.roleId,
      'status': instance.status,
      'last_login': instance.lastLogin.toIso8601String(),
      'login_type': instance.loginType,
      'perm': instance.permissions.map((e) => e.toJson()).toList(),
      'token': instance.token.toJson(),
    };
