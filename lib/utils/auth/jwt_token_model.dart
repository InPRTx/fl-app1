import 'package:json_annotation/json_annotation.dart';

part 'jwt_token_model.g.dart';

@JsonSerializable()
class JWTTokenModel {
  const JWTTokenModel({
    required this.exp,
    required this.iat,
    required this.sub,
    this.subjectAccess,
  });

  factory JWTTokenModel.fromJson(Map<String, dynamic> json) =>
      _$JWTTokenModelFromJson(json);

  /// Token expiration time (Unix timestamp)
  final int exp;

  /// Token issued at (Unix timestamp)
  final int iat;

  /// Subject (usually user ID)
  final String sub;

  /// Subject access information
  @JsonKey(name: 'subject_access')
  final SubjectAccess? subjectAccess;

  Map<String, dynamic> toJson() => _$JWTTokenModelToJson(this);
}

@JsonSerializable()
class SubjectAccess {
  const SubjectAccess({required this.email, this.userId, this.username});

  factory SubjectAccess.fromJson(Map<String, dynamic> json) =>
      _$SubjectAccessFromJson(json);

  final String email;

  @JsonKey(name: 'user_id')
  final int? userId;

  final String? username;

  Map<String, dynamic> toJson() => _$SubjectAccessToJson(this);
}
