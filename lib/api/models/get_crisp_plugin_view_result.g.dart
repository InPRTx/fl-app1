// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_crisp_plugin_view_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCrispPluginViewResult _$GetCrispPluginViewResultFromJson(
  Map<String, dynamic> json,
) => GetCrispPluginViewResult(
  result: json['result'] == null
      ? null
      : WebSubFastapiRoutersVCrispPluginViewGetCrispPluginViewResultResult.fromJson(
          json['result'] as Map<String, dynamic>,
        ),
  isSuccess: json['is_success'] as bool? ?? false,
  message: json['message'] as String? ?? '未找到用户',
);

Map<String, dynamic> _$GetCrispPluginViewResultToJson(
  GetCrispPluginViewResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
