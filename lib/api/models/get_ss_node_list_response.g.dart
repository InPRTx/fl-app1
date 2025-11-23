// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ss_node_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSsNodeListResponse _$GetSsNodeListResponseFromJson(
  Map<String, dynamic> json,
) => GetSsNodeListResponse(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map((e) => SsNodeOutput.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GetSsNodeListResponseToJson(
  GetSsNodeListResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
