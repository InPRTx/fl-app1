// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_link_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesLinkTokenResponse _$UserServicesLinkTokenResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesLinkTokenResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesLinkTokenResponseToJson(
  UserServicesLinkTokenResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
