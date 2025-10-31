// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_get_me_get_me_get_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult {
  const WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult({
    required this.userId,
    required this.userNewId,
    required this.email,
    required this.userName,
    required this.userAccountExpireIn,
    this.tgId,
    this.isBan = false,
  });

  factory WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResultFromJson(
          json);
  
  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 用户新型ID
  @JsonKey(name: 'user_new_id')
  final String userNewId;

  /// 用户邮箱
  final String email;

  /// 是否被禁用
  @JsonKey(name: 'is_ban')
  final bool isBan;

  /// Telegram ID
  @JsonKey(name: 'tg_id')
  final int? tgId;

  /// 用户昵称
  @JsonKey(name: 'user_name')
  final String userName;

  /// 用户到期时间
  @JsonKey(name: 'user_account_expire_in')
  final DateTime userAccountExpireIn;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResultToJson(this);
}
