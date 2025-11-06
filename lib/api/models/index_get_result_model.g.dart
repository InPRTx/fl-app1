// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_get_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexGetResultModel _$IndexGetResultModelFromJson(Map<String, dynamic> json) =>
    IndexGetResultModel(
      result:
          WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult.fromJson(
            json['result'] as Map<String, dynamic>,
          ),
      isSuccess: json['is_success'] as bool? ?? true,
      message: json['message'] as String? ?? '获取成功',
    );

Map<String, dynamic> _$IndexGetResultModelToJson(
  IndexGetResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
