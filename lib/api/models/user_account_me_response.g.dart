// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountMeResponse _$UserAccountMeResponseFromJson(
  Map<String, dynamic> json,
) => UserAccountMeResponse(
  result:
      WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserAccountMeResponseToJson(
  UserAccountMeResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
