// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_ss_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesSsPasswordResponse _$UserServicesSsPasswordResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesSsPasswordResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesSsPasswordResponseToJson(
  UserServicesSsPasswordResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
