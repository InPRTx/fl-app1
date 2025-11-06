// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_refresh_post_result_model_result.dart';

part 'refresh_post_result_model.g.dart';

@JsonSerializable()
class RefreshPostResultModel {
  const RefreshPostResultModel({
    required this.message,
    required this.result,
    this.isSuccess = false,
  });

  factory RefreshPostResultModel.fromJson(Map<String, Object?> json) =>
      _$RefreshPostResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 登录结果
  final String message;

  /// 登录结果
  final WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult
  result;

  Map<String, Object?> toJson() => _$RefreshPostResultModelToJson(this);
}
