// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'login_record.dart';

part 'user_account_login_history_response.g.dart';

@JsonSerializable()
class UserAccountLoginHistoryResponse {
  const UserAccountLoginHistoryResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserAccountLoginHistoryResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountLoginHistoryResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 登录历史记录
  final List<LoginRecord> result;

  Map<String, Object?> toJson() =>
      _$UserAccountLoginHistoryResponseToJson(this);
}
