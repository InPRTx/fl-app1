import 'package:json_annotation/json_annotation.dart';

part 'jwt_token_model.g.dart';

@JsonSerializable()
class JWTTokenModel {
  const JWTTokenModel({
    required this.exp,
    required this.iat,
    this.jti,
    this.role,
    this.sub,
    this.subjectAccess,
    this.subjectRefresh,
    this.tokenType,
  });

  factory JWTTokenModel.fromJson(Map<String, dynamic> json) =>
      _$JWTTokenModelFromJson(json);

  /// Token expiration time (Unix timestamp)
  final int exp;

  /// Token issued at (Unix timestamp)
  final int iat;

  /// JWT ID
  final String? jti;

  /// User role
  final String? role;

  /// Subject (optional)
  final String? sub;

  /// Subject access information (for access tokens)
  @JsonKey(name: 'subject_access')
  final SubjectAccess? subjectAccess;

  /// Subject refresh information (for refresh tokens)
  @JsonKey(name: 'subject_refresh')
  final SubjectRefresh? subjectRefresh;

  /// Token type (access or refresh)
  @JsonKey(name: 'token_type')
  final String? tokenType;

  Map<String, dynamic> toJson() => _$JWTTokenModelToJson(this);
}

@JsonSerializable()
class SubjectAccess {
  const SubjectAccess({
    required this.email,
    this.userId,
    this.userNewId,
    this.userName,
  });

  factory SubjectAccess.fromJson(Map<String, dynamic> json) =>
      _$SubjectAccessFromJson(json);

  final String email;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'user_new_id')
  final String? userNewId;

  @JsonKey(name: 'user_name')
  final String? userName;

  Map<String, dynamic> toJson() => _$SubjectAccessToJson(this);
}

@JsonSerializable()
class SubjectRefresh {
  const SubjectRefresh({this.userId, this.passwordHash, this.isRememberMe});

  factory SubjectRefresh.fromJson(Map<String, dynamic> json) =>
      _$SubjectRefreshFromJson(json);

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'password_hash')
  final String? passwordHash;

  @JsonKey(name: 'is_remember_me')
  final bool? isRememberMe;

  Map<String, dynamic> toJson() => _$SubjectRefreshToJson(this);
}
