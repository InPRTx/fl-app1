// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_node_config_ssr_config.dart';
import 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_node_config_vmess_config.dart';

part 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_node_config.g.dart';

@JsonSerializable()
class WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig {
  const WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig({
    this.host,
    this.port,
    this.vmessConfig,
    this.ssrConfig,
  });

  factory WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigFromJson(
        json,
      );

  @JsonKey(includeIfNull: false)
  final String? host;
  @JsonKey(includeIfNull: false)
  final int? port;
  @JsonKey(includeIfNull: false, name: 'vmess_config')
  final WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfig?
  vmessConfig;
  @JsonKey(includeIfNull: false, name: 'ssr_config')
  final WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfig?
  ssrConfig;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigToJson(
        this,
      );
}
