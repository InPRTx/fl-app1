// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_ssr_config.dart';
import 'ss_node_vmess_config.dart';

part 'ss_node_node_config.g.dart';

/// 节点配置
@JsonSerializable()
class SsNodeNodeConfig {
  const SsNodeNodeConfig({
    this.host,
    this.port,
    this.vmessConfig,
    this.ssrConfig,
  });

  factory SsNodeNodeConfig.fromJson(Map<String, Object?> json) =>
      _$SsNodeNodeConfigFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? host;
  @JsonKey(includeIfNull: false)
  final int? port;
  @JsonKey(includeIfNull: false, name: 'vmess_config')
  final SsNodeVmessConfig? vmessConfig;
  @JsonKey(includeIfNull: false, name: 'ssr_config')
  final SsNodeSsrConfig? ssrConfig;

  Map<String, Object?> toJson() => _$SsNodeNodeConfigToJson(this);
}
