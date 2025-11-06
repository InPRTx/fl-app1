// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRecord _$LoginRecordFromJson(Map<String, dynamic> json) => LoginRecord(
  loginTime: (json['login_time'] as num).toInt(),
  ipAddress: json['ip_address'] as String,
  userAgent: json['user_agent'] as String,
);

Map<String, dynamic> _$LoginRecordToJson(LoginRecord instance) =>
    <String, dynamic>{
      'login_time': instance.loginTime,
      'ip_address': instance.ipAddress,
      'user_agent': instance.userAgent,
    };
