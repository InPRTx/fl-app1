// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_register_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRegisterParamsModel _$AccountRegisterParamsModelFromJson(
  Map<String, dynamic> json,
) => AccountRegisterParamsModel(
  email: json['email'] as String,
  name: json['name'] as String,
  password: json['password'] as String,
  rePassword: json['re_password'] as String,
  inviteCode: json['invite_code'] as String?,
  emailCode: json['email_code'] as String?,
  verifyToken: json['verify_token'] as String?,
);

Map<String, dynamic> _$AccountRegisterParamsModelToJson(
  AccountRegisterParamsModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'name': instance.name,
  'password': instance.password,
  're_password': instance.rePassword,
  'invite_code': ?instance.inviteCode,
  'email_code': ?instance.emailCode,
  'verify_token': ?instance.verifyToken,
};
