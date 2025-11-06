// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_link_telegram_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountLinkTelegramResponse _$UserAccountLinkTelegramResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountLinkTelegramResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountLinkTelegramResponseToJson(
  UserAccountLinkTelegramResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
