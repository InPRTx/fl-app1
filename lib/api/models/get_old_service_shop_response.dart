// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'old_service_shop_output.dart';

part 'get_old_service_shop_response.g.dart';

@JsonSerializable()
class GetOldServiceShopResponse {
  const GetOldServiceShopResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetOldServiceShopResponse.fromJson(Map<String, Object?> json) =>
      _$GetOldServiceShopResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 管理员用户信息
  @JsonKey(includeIfNull: false)
  final OldServiceShopOutput? result;

  Map<String, Object?> toJson() => _$GetOldServiceShopResponseToJson(this);
}
