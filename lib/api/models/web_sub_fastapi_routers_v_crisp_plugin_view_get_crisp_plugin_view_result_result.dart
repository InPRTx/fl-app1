// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_v_crisp_plugin_view_get_crisp_plugin_view_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult {
  const WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult({
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.email,
    required this.ssYesterdayUsedSize,
    required this.isEnabled,
    required this.moneyAmount,
    required this.moneyAmount2,
    required this.userLevelExpireIn,
    required this.userAccountExpireIn,
    this.ssInitSize = 0,
    this.ssInit2Size = 0,
    this.ssTxSize = 0,
    this.ssRxSize = 0,
    this.userRemark = '',
    this.dataCreatedAt,
    this.nodeSpeedlimit,
    this.nodeConnector,
    this.tgId,
  });

  factory WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResultFromJson(
        json,
      );

  @JsonKey(includeIfNull: false, name: 'data_created_at')
  final DateTime? dataCreatedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'user_name')
  final String userName;
  final String email;
  @JsonKey(name: 'ss_init_size')
  final int ssInitSize;
  @JsonKey(name: 'ss_init2_size')
  final int ssInit2Size;

  /// 上传数量 u
  @JsonKey(name: 'ss_tx_size')
  final int ssTxSize;

  /// 下载数量 d
  @JsonKey(name: 'ss_rx_size')
  final int ssRxSize;
  @JsonKey(name: 'ss_yesterday_used_size')
  final int ssYesterdayUsedSize;
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;
  @JsonKey(name: 'user_remark')
  final String userRemark;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(name: 'money_amount2')
  final String moneyAmount2;
  @JsonKey(name: 'user_level_expire_in')
  final DateTime userLevelExpireIn;
  @JsonKey(name: 'user_account_expire_in')
  final DateTime userAccountExpireIn;
  @JsonKey(includeIfNull: false, name: 'node_speedlimit')
  final String? nodeSpeedlimit;
  @JsonKey(includeIfNull: false, name: 'node_connector')
  final int? nodeConnector;
  @JsonKey(includeIfNull: false, name: 'tg_id')
  final int? tgId;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResultToJson(
        this,
      );
}
