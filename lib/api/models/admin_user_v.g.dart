// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_v.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserV _$AdminUserVFromJson(Map<String, dynamic> json) => AdminUserV(
  id: (json['id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  email: json['email'] as String,
  userName: json['user_name'] as String,
  isEnable: json['is_enable'] as bool,
  telegramId: (json['telegram_id'] as num?)?.toInt(),
  regIp: json['reg_ip'],
  userAccountExpireIn: DateTime.parse(json['user_account_expire_in'] as String),
  isEmailVerify: json['is_email_verify'] as bool? ?? false,
);

Map<String, dynamic> _$AdminUserVToJson(AdminUserV instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'email': instance.email,
      'user_name': instance.userName,
      'is_enable': instance.isEnable,
      'telegram_id': instance.telegramId,
      'reg_ip': instance.regIp,
      'is_email_verify': instance.isEmailVerify,
      'user_account_expire_in': instance.userAccountExpireIn.toIso8601String(),
    };
