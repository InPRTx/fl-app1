// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_crisp_data_crisp_data_result_model_result.dart';

part 'crisp_data_result_model.g.dart';

@JsonSerializable()
class CrispDataResultModel {
  const CrispDataResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory CrispDataResultModel.fromJson(Map<String, Object?> json) =>
      _$CrispDataResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// crisp格式的用户信息
  final WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult result;

  Map<String, Object?> toJson() => _$CrispDataResultModelToJson(this);
}
