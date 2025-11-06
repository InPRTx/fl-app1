// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_password_change_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountPasswordChangeRequest _$UserAccountPasswordChangeRequestFromJson(
  Map<String, dynamic> json,
) => UserAccountPasswordChangeRequest(
  currentPassword: json['current_password'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$UserAccountPasswordChangeRequestToJson(
  UserAccountPasswordChangeRequest instance,
) => <String, dynamic>{
  'current_password': instance.currentPassword,
  'new_password': instance.newPassword,
};
