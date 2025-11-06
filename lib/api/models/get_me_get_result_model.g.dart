// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_me_get_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeGetResultModel _$GetMeGetResultModelFromJson(Map<String, dynamic> json) =>
    GetMeGetResultModel(
      result:
          WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult.fromJson(
            json['result'] as Map<String, dynamic>,
          ),
      isSuccess: json['is_success'] as bool? ?? true,
      message: json['message'] as String? ?? '获取成功',
    );

Map<String, dynamic> _$GetMeGetResultModelToJson(
  GetMeGetResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
