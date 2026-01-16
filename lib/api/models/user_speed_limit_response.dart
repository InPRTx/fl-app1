// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_speed_limit.dart';

part 'user_speed_limit_response.g.dart';

/// 单个限速记录响应
@JsonSerializable()
class UserSpeedLimitResponse {
  const UserSpeedLimitResponse({
    this.result,
    this.isSuccess = true,
    this.message = '操作成功',
  });

  factory UserSpeedLimitResponse.fromJson(Map<String, Object?> json) =>
      _$UserSpeedLimitResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  final String message;

  /// 限速记录
  @JsonKey(includeIfNull: false)
  final UserSpeedLimit? result;

  Map<String, Object?> toJson() => _$UserSpeedLimitResponseToJson(this);
}
