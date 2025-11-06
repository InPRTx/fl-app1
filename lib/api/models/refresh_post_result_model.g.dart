// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_post_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshPostResultModel _$RefreshPostResultModelFromJson(
  Map<String, dynamic> json,
) => RefreshPostResultModel(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? false,
);

Map<String, dynamic> _$RefreshPostResultModelToJson(
  RefreshPostResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
