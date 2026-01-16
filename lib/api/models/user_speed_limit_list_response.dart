// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_speed_limit.dart';

part 'user_speed_limit_list_response.g.dart';

/// 限速记录列表响应
@JsonSerializable()
class UserSpeedLimitListResponse {
  const UserSpeedLimitListResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
    this.total = 0,
  });

  factory UserSpeedLimitListResponse.fromJson(Map<String, Object?> json) =>
      _$UserSpeedLimitListResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  final String message;

  /// 限速记录列表
  @JsonKey(includeIfNull: false)
  final List<UserSpeedLimit>? result;

  /// 总记录数
  final int total;

  Map<String, Object?> toJson() => _$UserSpeedLimitListResponseToJson(this);
}
