// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_password_change_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountPasswordChangeResponse _$UserAccountPasswordChangeResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountPasswordChangeResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountPasswordChangeResponseToJson(
  UserAccountPasswordChangeResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
