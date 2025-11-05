// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_auth_cookies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppAuthCookiesModel _$AppAuthCookiesModelFromJson(Map<String, dynamic> json) =>
    AppAuthCookiesModel(
      isLogin: json['is_login'] as bool? ?? false,
      isAdmin: json['is_admin'] as bool? ?? false,
      uid: (json['uid'] as num?)?.toInt(),
      email: json['email'] as String?,
      expireIn: (json['expire_in'] as num?)?.toInt(),
      ip: json['ip'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$AppAuthCookiesModelToJson(
  AppAuthCookiesModel instance,
) => <String, dynamic>{
  'uid': ?instance.uid,
  'email': ?instance.email,
  'expire_in': ?instance.expireIn,
  'ip': ?instance.ip,
  'key': ?instance.key,
  'is_login': instance.isLogin,
  'is_admin': instance.isAdmin,
};
