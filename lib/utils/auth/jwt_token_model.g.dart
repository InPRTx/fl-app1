// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTTokenModel _$JWTTokenModelFromJson(Map<String, dynamic> json) =>
    JWTTokenModel(
      exp: (json['exp'] as num).toInt(),
      iat: (json['iat'] as num).toInt(),
      jti: json['jti'] as String?,
      role: json['role'] as String?,
      sub: json['sub'] as String?,
      subjectAccess: json['subject_access'] == null
          ? null
          : SubjectAccess.fromJson(
              json['subject_access'] as Map<String, dynamic>,
            ),
      subjectRefresh: json['subject_refresh'] == null
          ? null
          : SubjectRefresh.fromJson(
              json['subject_refresh'] as Map<String, dynamic>,
            ),
      tokenType: json['token_type'] as String?,
    );

Map<String, dynamic> _$JWTTokenModelToJson(JWTTokenModel instance) =>
    <String, dynamic>{
      'exp': instance.exp,
      'iat': instance.iat,
      'jti': instance.jti,
      'role': instance.role,
      'sub': instance.sub,
      'subject_access': instance.subjectAccess,
      'subject_refresh': instance.subjectRefresh,
      'token_type': instance.tokenType,
    };

SubjectAccess _$SubjectAccessFromJson(Map<String, dynamic> json) =>
    SubjectAccess(
      email: json['email'] as String,
      userId: (json['user_id'] as num?)?.toInt(),
      userNewId: json['user_new_id'] as String?,
      userName: json['user_name'] as String?,
      isAdmin: json['is_admin'] as bool?,
    );

Map<String, dynamic> _$SubjectAccessToJson(SubjectAccess instance) =>
    <String, dynamic>{
      'email': instance.email,
      'user_id': instance.userId,
      'user_new_id': instance.userNewId,
      'user_name': instance.userName,
      'is_admin': instance.isAdmin,
    };

SubjectRefresh _$SubjectRefreshFromJson(Map<String, dynamic> json) =>
    SubjectRefresh(
      userId: (json['user_id'] as num?)?.toInt(),
      passwordHash: json['password_hash'] as String?,
      isRememberMe: json['is_remember_me'] as bool?,
    );

Map<String, dynamic> _$SubjectRefreshToJson(SubjectRefresh instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'password_hash': instance.passwordHash,
      'is_remember_me': instance.isRememberMe,
    };
