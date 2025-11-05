// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_old_v_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginOldVResultModel _$PostLoginOldVResultModelFromJson(
  Map<String, dynamic> json,
) => PostLoginOldVResultModel(
  result: AppAuthCookiesModel.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$PostLoginOldVResultModelToJson(
  PostLoginOldVResultModel instance,
) => <String, dynamic>{
  'is_success': ?instance.isSuccess,
  'message': ?instance.message,
  'result': instance.result,
};
