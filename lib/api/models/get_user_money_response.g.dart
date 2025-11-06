// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_money_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserMoneyResponse _$GetUserMoneyResponseFromJson(
  Map<String, dynamic> json,
) => GetUserMoneyResponse(
  result: json['result'] == null
      ? null
      : AdminUserMoneyModel.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetUserMoneyResponseToJson(
  GetUserMoneyResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
