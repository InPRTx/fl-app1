// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_share_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesShareAccountResponse _$UserServicesShareAccountResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesShareAccountResponse(
  result:
      WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserServicesShareAccountResponseToJson(
  UserServicesShareAccountResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
