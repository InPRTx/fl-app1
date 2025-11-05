// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_view_user_bought_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetViewUserBoughtResult _$GetViewUserBoughtResultFromJson(
  Map<String, dynamic> json,
) => GetViewUserBoughtResult(
  result: json['result'] == null
      ? null
      : WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult.fromJson(
          json['result'] as Map<String, dynamic>,
        ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetViewUserBoughtResultToJson(
  GetViewUserBoughtResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
