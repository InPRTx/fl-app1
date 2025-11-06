// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_link_token_reset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesLinkTokenResetResponse _$UserServicesLinkTokenResetResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesLinkTokenResetResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesLinkTokenResetResponseToJson(
  UserServicesLinkTokenResetResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
