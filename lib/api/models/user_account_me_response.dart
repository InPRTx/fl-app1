// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_account_me_user_account_me_response_result.dart';

part 'user_account_me_response.g.dart';

@JsonSerializable()
class UserAccountMeResponse {
  const UserAccountMeResponse({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserAccountMeResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountMeResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户账户信息
  final WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult result;

  Map<String, Object?> toJson() => _$UserAccountMeResponseToJson(this);
}
