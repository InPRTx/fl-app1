// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_v_crisp_plugin_view_get_crisp_plugin_view_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult
_$WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult(
  createdAt: DateTime.parse(json['created_at'] as String),
  userId: (json['user_id'] as num).toInt(),
  userName: json['user_name'] as String,
  email: json['email'] as String,
  ssYesterdayUsedSize: (json['ss_yesterday_used_size'] as num).toInt(),
  isEnabled: json['is_enabled'] as bool,
  moneyAmount: json['money_amount'] as String,
  moneyAmount2: json['money_amount2'] as String,
  userLevelExpireIn: DateTime.parse(json['user_level_expire_in'] as String),
  userAccountExpireIn: DateTime.parse(json['user_account_expire_in'] as String),
  ssInitSize: (json['ss_init_size'] as num?)?.toInt() ?? 0,
  ssInit2Size: (json['ss_init2_size'] as num?)?.toInt() ?? 0,
  ssTxSize: (json['ss_tx_size'] as num?)?.toInt() ?? 0,
  ssRxSize: (json['ss_rx_size'] as num?)?.toInt() ?? 0,
  userRemark: json['user_remark'] as String? ?? '',
  dataCreatedAt: json['data_created_at'] == null
      ? null
      : DateTime.parse(json['data_created_at'] as String),
  nodeSpeedlimit: json['node_speedlimit'] as String?,
  nodeConnector: (json['node_connector'] as num?)?.toInt(),
  tgId: (json['tg_id'] as num?)?.toInt(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResultToJson(
  WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult instance,
) => <String, dynamic>{
  'data_created_at': ?instance.dataCreatedAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'user_id': instance.userId,
  'user_name': instance.userName,
  'email': instance.email,
  'ss_init_size': instance.ssInitSize,
  'ss_init2_size': instance.ssInit2Size,
  'ss_tx_size': instance.ssTxSize,
  'ss_rx_size': instance.ssRxSize,
  'ss_yesterday_used_size': instance.ssYesterdayUsedSize,
  'is_enabled': instance.isEnabled,
  'user_remark': instance.userRemark,
  'money_amount': instance.moneyAmount,
  'money_amount2': instance.moneyAmount2,
  'user_level_expire_in': instance.userLevelExpireIn.toIso8601String(),
  'user_account_expire_in': instance.userAccountExpireIn.toIso8601String(),
  'node_speedlimit': ?instance.nodeSpeedlimit,
  'node_connector': ?instance.nodeConnector,
  'tg_id': ?instance.tgId,
};
