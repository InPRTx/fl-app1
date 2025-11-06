// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_invite_index_user_invite_response_result.dart';

part 'user_invite_response.g.dart';

@JsonSerializable()
class UserInviteResponse {
  const UserInviteResponse({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserInviteResponse.fromJson(Map<String, Object?> json) =>
      _$UserInviteResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户邀请信息
  final WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult result;

  Map<String, Object?> toJson() => _$UserInviteResponseToJson(this);
}
