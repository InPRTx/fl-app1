// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_auth_account_register_index_auth_register_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult
_$WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  userId: (json['user_id'] as num).toInt(),
  userName: json['user_name'] as String,
  email: json['email'] as String,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResultToJson(
  WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult
  instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'email': instance.email,
};
