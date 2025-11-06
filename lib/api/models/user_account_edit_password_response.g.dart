// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_edit_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountEditPasswordResponse _$UserAccountEditPasswordResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountEditPasswordResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountEditPasswordResponseToJson(
  UserAccountEditPasswordResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
