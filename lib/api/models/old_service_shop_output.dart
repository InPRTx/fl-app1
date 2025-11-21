// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'shop_type_enum.dart';

part 'old_service_shop_output.g.dart';

@JsonSerializable()
class OldServiceShopOutput {
  const OldServiceShopOutput({
    required this.id,
    required this.shopName,
    required this.moneyAmount,
    required this.contentExtra,
    this.shopGroupId = 0,
    this.shopType = ShopTypeEnum.mainPackage,
    this.isAutoResetBandwidth = false,
    this.isEnable = true,
    this.isCannotNewPurchase = false,
    this.createdAt,
    this.updatedAt,
    this.ssBandwidthTotalSize,
    this.userLevel,
    this.userLevelDuration,
    this.accountValidityDuration,
    this.ssBandwidthResetInterval,
    this.nodeSpeedLimit,
    this.nodeConnector,
    this.dataJson,
  });

  factory OldServiceShopOutput.fromJson(Map<String, Object?> json) =>
      _$OldServiceShopOutputFromJson(json);

  final int id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'shop_group_id')
  final int shopGroupId;
  @JsonKey(name: 'shop_type')
  final ShopTypeEnum shopType;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  /// 流量（字节）
  @JsonKey(includeIfNull: false, name: 'ss_bandwidth_total_size')
  final int? ssBandwidthTotalSize;

  /// 等级
  @JsonKey(includeIfNull: false, name: 'user_level')
  final int? userLevel;

  /// 等级有效期天数
  @JsonKey(includeIfNull: false, name: 'user_level_duration')
  final String? userLevelDuration;

  /// 账户有效期天数
  @JsonKey(includeIfNull: false, name: 'account_validity_duration')
  final String? accountValidityDuration;

  /// 每多少天重置流量 其中流量重置信息为上面几个等级
  @JsonKey(includeIfNull: false, name: 'ss_bandwidth_reset_interval')
  final String? ssBandwidthResetInterval;

  /// 端口限速
  @JsonKey(includeIfNull: false, name: 'node_speed_limit')
  final int? nodeSpeedLimit;

  /// IP限制
  @JsonKey(includeIfNull: false, name: 'node_connector')
  final int? nodeConnector;

  /// 服务支持
  @JsonKey(name: 'content_extra')
  final String contentExtra;
  @JsonKey(name: 'is_auto_reset_bandwidth')
  final bool isAutoResetBandwidth;
  @JsonKey(name: 'is_enable')
  final bool isEnable;
  @JsonKey(name: 'is_cannot_new_purchase')
  final bool isCannotNewPurchase;
  @JsonKey(includeIfNull: false, name: 'data_json')
  final dynamic dataJson;

  Map<String, Object?> toJson() => _$OldServiceShopOutputToJson(this);
}
