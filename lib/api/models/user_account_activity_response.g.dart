// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountActivityResponse _$UserAccountActivityResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountActivityResponse(
  result:
      WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserAccountActivityResponseToJson(
  UserAccountActivityResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
