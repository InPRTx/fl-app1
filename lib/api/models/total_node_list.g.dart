// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_node_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalNodeList _$TotalNodeListFromJson(Map<String, dynamic> json) =>
    TotalNodeList(
      dataStartAts: (json['data_start_ats'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$TotalNodeListToJson(TotalNodeList instance) =>
    <String, dynamic>{
      'data_start_ats': instance.dataStartAts
          .map((e) => e.toIso8601String())
          .toList(),
    };
