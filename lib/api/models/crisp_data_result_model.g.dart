// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crisp_data_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrispDataResultModel _$CrispDataResultModelFromJson(
  Map<String, dynamic> json,
) => CrispDataResultModel(
  result:
      WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$CrispDataResultModelToJson(
  CrispDataResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
