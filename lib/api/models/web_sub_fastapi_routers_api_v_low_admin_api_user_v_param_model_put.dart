// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_v_param_model_put.g.dart';

/// PUT 更新模型 - 需要提供所有必填字段，可选字段可不提供
@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut {
  const WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut({
    required this.email,
    required this.userName,
    required this.isEnable,
    required this.isEmailVerify,
    required this.userAccountExpireIn,
    this.telegramId,
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPutFromJson(json);

  /// 邮箱
  final String email;

  /// 用户名
  @JsonKey(name: 'user_name')
  final String userName;

  /// 是否启用
  @JsonKey(name: 'is_enable')
  final bool isEnable;

  /// Telegram ID
  @JsonKey(includeIfNull: false, name: 'telegram_id')
  final int? telegramId;

  /// 邮箱是否验证
  @JsonKey(name: 'is_email_verify')
  final bool isEmailVerify;

  /// 用户账户过期时间 expire_in
  @JsonKey(name: 'user_account_expire_in')
  final DateTime userAccountExpireIn;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPutToJson(this);
}
