// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_security_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountSecurityGetResponse _$UserAccountSecurityGetResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountSecurityGetResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountSecurityGetResponseToJson(
  UserAccountSecurityGetResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
