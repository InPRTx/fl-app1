// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_ssr_config_sql_model.dart';
import 'ss_node_vmess_config_sql_model.dart';

part 'ss_node_node_config_sql_model.g.dart';

/// 节点配置（SQLModel 版本）
@JsonSerializable()
class SsNodeNodeConfigSqlModel {
  const SsNodeNodeConfigSqlModel({
    this.host,
    this.port,
    this.vmessConfig,
    this.ssrConfig,
  });

  factory SsNodeNodeConfigSqlModel.fromJson(Map<String, Object?> json) =>
      _$SsNodeNodeConfigSqlModelFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? host;
  @JsonKey(includeIfNull: false)
  final int? port;
  @JsonKey(includeIfNull: false, name: 'vmess_config')
  final SsNodeVmessConfigSqlModel? vmessConfig;
  @JsonKey(includeIfNull: false, name: 'ssr_config')
  final SsNodeSsrConfigSqlModel? ssrConfig;

  Map<String, Object?> toJson() => _$SsNodeNodeConfigSqlModelToJson(this);
}
