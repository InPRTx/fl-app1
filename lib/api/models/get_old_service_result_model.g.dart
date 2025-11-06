// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_old_service_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOldServiceResultModel _$GetOldServiceResultModelFromJson(
  Map<String, dynamic> json,
) => GetOldServiceResultModel(
  result:
      WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetOldServiceResultModelToJson(
  GetOldServiceResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
