// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_view_user_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetViewUserResult _$GetViewUserResultFromJson(
  Map<String, dynamic> json,
) => GetViewUserResult(
  result: json['result'] == null
      ? null
      : WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult.fromJson(
          json['result'] as Map<String, dynamic>,
        ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetViewUserResultToJson(GetViewUserResult instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': ?instance.result,
    };
