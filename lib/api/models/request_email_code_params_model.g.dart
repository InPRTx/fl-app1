// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_code_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEmailCodeParamsModel _$RequestEmailCodeParamsModelFromJson(
  Map<String, dynamic> json,
) => RequestEmailCodeParamsModel(
  email: json['email'] as String?,
  verifyToken: json['verify_token'] as String?,
);

Map<String, dynamic> _$RequestEmailCodeParamsModelToJson(
  RequestEmailCodeParamsModel instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'verify_token': ?instance.verifyToken,
};
