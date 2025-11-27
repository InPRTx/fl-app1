// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_v_crisp_plugin_view_get_crisp_plugin_view_result_result.dart';

part 'get_crisp_plugin_view_result.g.dart';

@JsonSerializable()
class GetCrispPluginViewResult {
  const GetCrispPluginViewResult({
    this.result,
    this.isSuccess = false,
    this.message = '未找到用户',
  });

  factory GetCrispPluginViewResult.fromJson(Map<String, Object?> json) =>
      _$GetCrispPluginViewResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  final String message;
  @JsonKey(includeIfNull: false)
  final WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult?
  result;

  Map<String, Object?> toJson() => _$GetCrispPluginViewResultToJson(this);
}
