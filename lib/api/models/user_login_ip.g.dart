// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_ip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginIp _$UserLoginIpFromJson(Map<String, dynamic> json) => UserLoginIp(
  userId: (json['user_id'] as num).toInt(),
  loginIp: json['login_ip'] as String,
  isLogin: json['is_login'] as bool? ?? true,
  id: json['id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserLoginIpToJson(UserLoginIp instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'user_id': instance.userId,
      'login_ip': instance.loginIp,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'is_login': instance.isLogin,
    };
