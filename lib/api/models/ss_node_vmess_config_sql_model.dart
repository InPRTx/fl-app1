// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ss_node_vmess_config_sql_model.g.dart';

/// VMess 配置（SQLModel 版本）
@JsonSerializable()
class SsNodeVmessConfigSqlModel {
  const SsNodeVmessConfigSqlModel({
    this.host = '',
    this.verifyCert = true,
    this.port = 443,
    this.alterId = 0,
    this.netType = 'tcp',
  });

  factory SsNodeVmessConfigSqlModel.fromJson(Map<String, Object?> json) =>
      _$SsNodeVmessConfigSqlModelFromJson(json);

  final String host;
  @JsonKey(name: 'verify_cert')
  final bool verifyCert;
  final int port;
  @JsonKey(name: 'alter_id')
  final int alterId;
  @JsonKey(name: 'net_type')
  final String netType;

  Map<String, Object?> toJson() => _$SsNodeVmessConfigSqlModelToJson(this);
}
