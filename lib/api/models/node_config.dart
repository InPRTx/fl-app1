// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ssr_config.dart';
import 'vmess_config.dart';

part 'node_config.g.dart';

@JsonSerializable()
class NodeConfig {
  const NodeConfig({this.host, this.port, this.vmessConfig, this.ssrConfig});

  factory NodeConfig.fromJson(Map<String, Object?> json) =>
      _$NodeConfigFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? host;
  @JsonKey(includeIfNull: false)
  final int? port;
  @JsonKey(includeIfNull: false, name: 'vmess_config')
  final VmessConfig? vmessConfig;
  @JsonKey(includeIfNull: false, name: 'ssr_config')
  final SsrConfig? ssrConfig;

  Map<String, Object?> toJson() => _$NodeConfigToJson(this);
}
