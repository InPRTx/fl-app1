// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'old_service_info.dart';

part 'web_sub_fastapi_routers_api_v_user_dashboard_index_get_dashboard_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult {
  const WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult({
    required this.userId,
    required this.userNewId,
    required this.email,
    required this.userName,
    required this.moneyAmount,
    required this.oldServiceInfo,
    this.tgId,
    this.isBan = false,
  });

  factory WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResultFromJson(
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

  /// 用户余额，直接输出余额
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  /// 用户旧版服务信息
  @JsonKey(name: 'old_service_info')
  final OldServiceInfo? oldServiceInfo;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResultToJson(
          this);
}
