// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_security_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountSecurityPostRequest _$UserAccountSecurityPostRequestFromJson(
  Map<String, dynamic> json,
) => UserAccountSecurityPostRequest(
  gaEnable: json['ga_enable'] as bool?,
  emailNotification: json['email_notification'] as bool?,
  gaToken: json['ga_token'] as String?,
);

Map<String, dynamic> _$UserAccountSecurityPostRequestToJson(
  UserAccountSecurityPostRequest instance,
) => <String, dynamic>{
  'ga_enable': ?instance.gaEnable,
  'email_notification': ?instance.emailNotification,
  'ga_token': ?instance.gaToken,
};
