// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'country_code.dart';
import 'vpn_type_enum.dart';
import 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_node_config.dart';
import 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_user_group_host.dart';

part 'ss_node_pydantic.g.dart';

@JsonSerializable()
class SsNodePydantic {
  const SsNodePydantic({
    required this.id,
    required this.nodeName,
    required this.nodeConfig,
    this.priority = 60000,
    this.isEnable = true,
    this.iso3166Code = CountryCode.ar,
    this.vpnType = VpnTypeEnum.vmess,
    this.nodeRate = 1.00,
    this.nodeLevel = 0,
    this.isHideNode = false,
    this.createdAt,
    this.updatedAt,
    this.nodeInfo,
    this.remark,
    this.nodeSpeedLimit,
    this.userGroupHost,
  });

  factory SsNodePydantic.fromJson(Map<String, Object?> json) =>
      _$SsNodePydanticFromJson(json);

  @JsonKey(includeIfNull: true)
  final int? id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  final int priority;
  @JsonKey(name: 'node_name')
  final String nodeName;
  @JsonKey(name: 'node_config')
  final WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig
  nodeConfig;
  @JsonKey(name: 'is_enable')
  final bool isEnable;
  @JsonKey(name: 'iso3166_code')
  final CountryCode iso3166Code;
  @JsonKey(name: 'vpn_type')
  final VpnTypeEnum vpnType;
  @JsonKey(name: 'node_rate')
  final dynamic nodeRate;
  @JsonKey(name: 'node_level')
  final int nodeLevel;

  /// 节点信息
  @JsonKey(includeIfNull: false, name: 'node_info')
  final String? nodeInfo;

  /// 节点备注 remark
  @JsonKey(includeIfNull: false)
  final String? remark;

  /// 节点速度限制
  @JsonKey(includeIfNull: false, name: 'node_speed_limit')
  final dynamic nodeSpeedLimit;
  @JsonKey(includeIfNull: false, name: 'user_group_host')
  final WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost?
  userGroupHost;
  @JsonKey(name: 'is_hide_node')
  final bool isHideNode;

  Map<String, Object?> toJson() => _$SsNodePydanticToJson(this);
}
