// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_grafana_admin_view_view_user_bought_get_view_user_bought_result_result.dart';

part 'get_view_user_bought_result.g.dart';

@JsonSerializable()
class GetViewUserBoughtResult {
  const GetViewUserBoughtResult({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetViewUserBoughtResult.fromJson(Map<String, Object?> json) =>
      _$GetViewUserBoughtResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 旧版商店信息
  @JsonKey(includeIfNull: false)
  final WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult?
  result;

  Map<String, Object?> toJson() => _$GetViewUserBoughtResultToJson(this);
}
