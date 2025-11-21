// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'old_service_shop_output.dart';

part 'get_old_service_shop_list_response.g.dart';

@JsonSerializable()
class GetOldServiceShopListResponse {
  const GetOldServiceShopListResponse({
    this.isSuccess = true,
    this.message = '获取成功',
    this.resultList = const [],
  });

  factory GetOldServiceShopListResponse.fromJson(Map<String, Object?> json) =>
      _$GetOldServiceShopListResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 管理员用户信息
  @JsonKey(name: 'result_list')
  final List<OldServiceShopOutput> resultList;

  Map<String, Object?> toJson() => _$GetOldServiceShopListResponseToJson(this);
}
