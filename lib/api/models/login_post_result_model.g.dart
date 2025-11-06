// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_post_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPostResultModel _$LoginPostResultModelFromJson(
  Map<String, dynamic> json,
) => LoginPostResultModel(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$LoginPostResultModelToJson(
  LoginPostResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
