// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParamsModel _$ParamsModelFromJson(Map<String, dynamic> json) => ParamsModel(
  email: json['email'] as String,
  password: json['password'] as String,
  isRememberMe: json['is_remember_me'] as bool? ?? false,
  twoFaCode: json['two_fa_code'] as String?,
  verifyToken: json['verify_token'] as String?,
);

Map<String, dynamic> _$ParamsModelToJson(ParamsModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'two_fa_code': ?instance.twoFaCode,
      'is_remember_me': instance.isRememberMe,
      'verify_token': ?instance.verifyToken,
    };
