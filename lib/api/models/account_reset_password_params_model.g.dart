// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_reset_password_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountResetPasswordParamsModel _$AccountResetPasswordParamsModelFromJson(
  Map<String, dynamic> json,
) => AccountResetPasswordParamsModel(
  emailCode: json['email_code'] as String,
  password: json['password'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$AccountResetPasswordParamsModelToJson(
  AccountResetPasswordParamsModel instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'email_code': instance.emailCode,
  'password': instance.password,
};
