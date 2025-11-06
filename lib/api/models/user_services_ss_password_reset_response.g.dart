// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_ss_password_reset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesSsPasswordResetResponse
_$UserServicesSsPasswordResetResponseFromJson(Map<String, dynamic> json) =>
    UserServicesSsPasswordResetResponse(
      message: json['message'] as String,
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserServicesSsPasswordResetResponseToJson(
  UserServicesSsPasswordResetResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
