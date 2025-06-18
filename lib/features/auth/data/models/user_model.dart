import 'package:json_annotation/json_annotation.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String token;

  UserModel({required this.id, required this.name, required this.token});

  /// Wraps generated parsing in a try/catch to throw ParsingFailure
  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserModelFromJson(json);
    } catch (e) {
      throw ParsingFailure(rawMessage: 'Invalid user data: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert to your domain entity
  User toEntity() => User(id: id, name: name, token: token);
}
