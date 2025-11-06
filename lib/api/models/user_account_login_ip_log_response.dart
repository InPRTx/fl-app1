// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_login_ip.dart';

part 'user_account_login_ip_log_response.g.dart';

@JsonSerializable()
class UserAccountLoginIpLogResponse {
  const UserAccountLoginIpLogResponse({
    required this.message,
    required this.resultList,
    this.isSuccess = true,
  });

  factory UserAccountLoginIpLogResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountLoginIpLogResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 登录IP日志列表
  @JsonKey(name: 'result_list')
  final List<UserLoginIp> resultList;

  Map<String, Object?> toJson() => _$UserAccountLoginIpLogResponseToJson(this);
}
