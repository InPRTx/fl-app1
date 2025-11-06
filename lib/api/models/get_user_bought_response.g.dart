// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_bought_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserBoughtResponse _$GetUserBoughtResponseFromJson(
  Map<String, dynamic> json,
) => GetUserBoughtResponse(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map(
            (e) =>
                WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData.fromJson(
                  e as Map<String, dynamic>,
                ),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$GetUserBoughtResponseToJson(
  GetUserBoughtResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
