// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_edit_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountEditEmailResponse _$UserAccountEditEmailResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountEditEmailResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountEditEmailResponseToJson(
  UserAccountEditEmailResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
