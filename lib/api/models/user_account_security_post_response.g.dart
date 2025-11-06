// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_security_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountSecurityPostResponse _$UserAccountSecurityPostResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountSecurityPostResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountSecurityPostResponseToJson(
  UserAccountSecurityPostResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
