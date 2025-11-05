// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_auth_jwt_token_login_old_v_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel
_$WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModelFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel(
  accessToken: json['access_token'] as String?,
  refreshToken: json['refresh_token'] as String?,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModelToJson(
  WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel instance,
) => <String, dynamic>{
  'access_token': ?instance.accessToken,
  'refresh_token': ?instance.refreshToken,
};
