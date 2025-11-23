// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'get_usernames_response.g.dart';

@JsonSerializable()
class GetUsernamesResponse {
  const GetUsernamesResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetUsernamesResponse.fromJson(Map<String, Object?> json) =>
      _$GetUsernamesResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 用户ID到用户名的映射
  @JsonKey(includeIfNull: false)
  final Map<String, String>? result;

  Map<String, Object?> toJson() => _$GetUsernamesResponseToJson(this);
}
