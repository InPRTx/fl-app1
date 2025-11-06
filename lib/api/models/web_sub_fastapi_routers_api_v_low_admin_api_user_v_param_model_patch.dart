// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_v_param_model_patch.g.dart';

/// PATCH 更新模型 - 只更新提供的字段
@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch {
  const WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch({
    this.email,
    this.userName,
    this.isEnable,
    this.telegramId,
    this.isEmailVerify,
    this.userAccountExpireIn,
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatchFromJson(json);

  /// 邮箱
  @JsonKey(includeIfNull: false)
  final String? email;

  /// 用户名
  @JsonKey(includeIfNull: false, name: 'user_name')
  final String? userName;

  /// 是否启用
  @JsonKey(includeIfNull: false, name: 'is_enable')
  final bool? isEnable;

  /// Telegram ID
  @JsonKey(includeIfNull: false, name: 'telegram_id')
  final int? telegramId;

  /// 邮箱是否验证
  @JsonKey(includeIfNull: false, name: 'is_email_verify')
  final bool? isEmailVerify;

  /// 用户账户过期时间 expire_in
  @JsonKey(includeIfNull: false, name: 'user_account_expire_in')
  final DateTime? userAccountExpireIn;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatchToJson(this);
}
