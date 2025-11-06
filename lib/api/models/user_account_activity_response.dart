// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_account_activity_user_account_activity_response_result.dart';

part 'user_account_activity_response.g.dart';

@JsonSerializable()
class UserAccountActivityResponse {
  const UserAccountActivityResponse({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserAccountActivityResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountActivityResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户活动信息
  final WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult
  result;

  Map<String, Object?> toJson() => _$UserAccountActivityResponseToJson(this);
}
