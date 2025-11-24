// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_node_config_ssr_config.g.dart';

/// SSR配置
@JsonSerializable()
class WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfig {
  const WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfig({
    this.host = '',
    this.port = 443,
    this.password = '',
    this.method = 'aes-256-cfb',
    this.protocol = 'origin',
    this.protocolParam = '',
    this.obfs = 'plain',
    this.obfsParam = '',
  });

  factory WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfig.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfigFromJson(
        json,
      );

  final String host;
  final int port;
  final String password;
  final String method;
  final String protocol;
  @JsonKey(name: 'protocol_param')
  final String protocolParam;
  final String obfs;
  @JsonKey(name: 'obfs_param')
  final String obfsParam;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfigToJson(
        this,
      );
}
