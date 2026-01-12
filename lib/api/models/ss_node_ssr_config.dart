// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ss_node_ssr_config.g.dart';

/// SSR 配置
@JsonSerializable()
class SsNodeSsrConfig {
  const SsNodeSsrConfig({
    this.host = '',
    this.port = 443,
    this.password = '',
    this.method = 'aes-256-cfb',
    this.protocol = 'origin',
    this.protocolParam = '',
    this.obfs = 'plain',
    this.obfsParam = '',
  });

  factory SsNodeSsrConfig.fromJson(Map<String, Object?> json) =>
      _$SsNodeSsrConfigFromJson(json);

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

  Map<String, Object?> toJson() => _$SsNodeSsrConfigToJson(this);
}
