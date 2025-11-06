// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_dashboard_index_get_dashboard_result_model_result.dart';

part 'get_dashboard_result_model.g.dart';

@JsonSerializable()
class GetDashboardResultModel {
  const GetDashboardResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetDashboardResultModel.fromJson(Map<String, Object?> json) =>
      _$GetDashboardResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户信息
  final WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult
  result;

  Map<String, Object?> toJson() => _$GetDashboardResultModelToJson(this);
}
