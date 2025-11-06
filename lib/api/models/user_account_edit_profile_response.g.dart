// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_edit_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountEditProfileResponse _$UserAccountEditProfileResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountEditProfileResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountEditProfileResponseToJson(
  UserAccountEditProfileResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
