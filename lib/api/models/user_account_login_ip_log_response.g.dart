// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_login_ip_log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountLoginIpLogResponse _$UserAccountLoginIpLogResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountLoginIpLogResponse(
  message: json['message'] as String,
  resultList: (json['result_list'] as List<dynamic>)
      .map((e) => UserLoginIp.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserAccountLoginIpLogResponseToJson(
  UserAccountLoginIpLogResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
