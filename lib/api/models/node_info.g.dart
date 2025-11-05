// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeInfo _$NodeInfoFromJson(Map<String, dynamic> json) => NodeInfo(
  nodeId: (json['node_id'] as num).toInt(),
  nodeName: json['node_name'] as String,
  serverAddress: json['server_address'] as String,
  location: json['location'] as String,
  countryCode: json['country_code'] as String,
  load: json['load'] as num,
  status: json['status'] as String,
  protocolSupport: (json['protocol_support'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  bandwidth: json['bandwidth'] as String,
  isPremium: json['is_premium'] as bool,
  ping: (json['ping'] as num?)?.toInt(),
);

Map<String, dynamic> _$NodeInfoToJson(NodeInfo instance) => <String, dynamic>{
  'node_id': instance.nodeId,
  'node_name': instance.nodeName,
  'server_address': instance.serverAddress,
  'location': instance.location,
  'country_code': instance.countryCode,
  'ping': ?instance.ping,
  'load': instance.load,
  'status': instance.status,
  'protocol_support': instance.protocolSupport,
  'bandwidth': instance.bandwidth,
  'is_premium': instance.isPremium,
};
