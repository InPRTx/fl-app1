// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_auth_account_login_index_login_post_result_model_result.dart';

part 'login_post_result_model.g.dart';

@JsonSerializable()
class LoginPostResultModel {
  const LoginPostResultModel({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory LoginPostResultModel.fromJson(Map<String, Object?> json) =>
      _$LoginPostResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 登录结果
  final String message;

  /// 登录结果
  final WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult
  result;

  Map<String, Object?> toJson() => _$LoginPostResultModelToJson(this);
}
