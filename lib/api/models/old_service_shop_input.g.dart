// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_service_shop_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OldServiceShopInput _$OldServiceShopInputFromJson(Map<String, dynamic> json) =>
    OldServiceShopInput(
      id: (json['id'] as num).toInt(),
      shopName: json['shop_name'] as String,
      moneyAmount: json['money_amount'],
      contentExtra: json['content_extra'] as String,
      shopGroupId: (json['shop_group_id'] as num?)?.toInt() ?? 0,
      shopType:
          $enumDecodeNullable(_$ShopTypeEnumEnumMap, json['shop_type']) ??
          ShopTypeEnum.mainPackage,
      isAutoResetBandwidth: json['is_auto_reset_bandwidth'] as bool? ?? false,
      isEnable: json['is_enable'] as bool? ?? true,
      isCannotNewPurchase: json['is_cannot_new_purchase'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      ssBandwidthTotalSize: (json['ss_bandwidth_total_size'] as num?)?.toInt(),
      userLevel: (json['user_level'] as num?)?.toInt(),
      userLevelDuration: json['user_level_duration'] as String?,
      accountValidityDuration: json['account_validity_duration'] as String?,
      ssBandwidthResetInterval: json['ss_bandwidth_reset_interval'] as String?,
      nodeSpeedLimit: (json['node_speed_limit'] as num?)?.toInt(),
      nodeConnector: (json['node_connector'] as num?)?.toInt(),
      dataJson: json['data_json'],
    );

Map<String, dynamic> _$OldServiceShopInputToJson(
  OldServiceShopInput instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'shop_name': instance.shopName,
  'shop_group_id': instance.shopGroupId,
  'shop_type': _$ShopTypeEnumEnumMap[instance.shopType]!,
  'money_amount': instance.moneyAmount,
  'ss_bandwidth_total_size': ?instance.ssBandwidthTotalSize,
  'user_level': ?instance.userLevel,
  'user_level_duration': ?instance.userLevelDuration,
  'account_validity_duration': ?instance.accountValidityDuration,
  'ss_bandwidth_reset_interval': ?instance.ssBandwidthResetInterval,
  'node_speed_limit': ?instance.nodeSpeedLimit,
  'node_connector': ?instance.nodeConnector,
  'content_extra': instance.contentExtra,
  'is_auto_reset_bandwidth': instance.isAutoResetBandwidth,
  'is_enable': instance.isEnable,
  'is_cannot_new_purchase': instance.isCannotNewPurchase,
  'data_json': ?instance.dataJson,
};

const _$ShopTypeEnumEnumMap = {
  ShopTypeEnum.mainPackage: 'main_package',
  ShopTypeEnum.additionalPackage: 'additional_package',
  ShopTypeEnum.checkinPackage: 'checkin_package',
  ShopTypeEnum.debuffPackage: 'debuff_package',
};
