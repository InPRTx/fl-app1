// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'old_service_shop.dart';

part 'get_service_old_shop_result.g.dart';

@JsonSerializable()
class GetServiceOldShopResult {
  const GetServiceOldShopResult({
    this.isSuccess = true,
    this.message = '获取成功',
    this.resultList = const [],
  });

  factory GetServiceOldShopResult.fromJson(Map<String, Object?> json) =>
      _$GetServiceOldShopResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 旧版商店信息
  @JsonKey(name: 'result_list')
  final List<OldServiceShop> resultList;

  Map<String, Object?> toJson() => _$GetServiceOldShopResultToJson(this);
}
