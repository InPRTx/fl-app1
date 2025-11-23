// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ss_node_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSsNodeResponse _$GetSsNodeResponseFromJson(Map<String, dynamic> json) =>
    GetSsNodeResponse(
      result: json['result'] == null
          ? null
          : SsNodeOutput.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['is_success'] as bool? ?? true,
      message: json['message'] as String? ?? '获取成功',
    );

Map<String, dynamic> _$GetSsNodeResponseToJson(GetSsNodeResponse instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': ?instance.result,
    };
