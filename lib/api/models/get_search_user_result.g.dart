// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_user_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchUserResult _$GetSearchUserResultFromJson(Map<String, dynamic> json) =>
    GetSearchUserResult(
      isSuccess: json['is_success'] as bool? ?? true,
      message: json['message'] as String? ?? '获取成功',
      resultList:
          (json['result_list'] as List<dynamic>?)
              ?.map((e) => ResultListData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetSearchUserResultToJson(
  GetSearchUserResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
