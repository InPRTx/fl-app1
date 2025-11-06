// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_shop_old_index_user_shop_old_result_result.dart';

part 'user_shop_old_result.g.dart';

@JsonSerializable()
class UserShopOldResult {
  const UserShopOldResult({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserShopOldResult.fromJson(Map<String, Object?> json) =>
      _$UserShopOldResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 旧版商店信息
  final WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult result;

  Map<String, Object?> toJson() => _$UserShopOldResultToJson(this);
}
