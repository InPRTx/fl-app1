// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_info.dart';

part 'get_user_infos_response.g.dart';

@JsonSerializable()
class GetUserInfosResponse {
  const GetUserInfosResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetUserInfosResponse.fromJson(Map<String, Object?> json) =>
      _$GetUserInfosResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 用户ID到用户信息的映射
  @JsonKey(includeIfNull: false)
  final Map<String, UserInfo>? result;

  Map<String, Object?> toJson() => _$GetUserInfosResponseToJson(this);
}
