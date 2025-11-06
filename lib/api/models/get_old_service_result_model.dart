// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_get_old_service_get_old_service_result_model_result.dart';

part 'get_old_service_result_model.g.dart';

@JsonSerializable()
class GetOldServiceResultModel {
  const GetOldServiceResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetOldServiceResultModel.fromJson(Map<String, Object?> json) =>
      _$GetOldServiceResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 旧版服务信息
  final WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult
  result;

  Map<String, Object?> toJson() => _$GetOldServiceResultModelToJson(this);
}
