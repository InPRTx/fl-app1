// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_refresh_post_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult
_$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult(
      accessToken: json['access_token'] as String,
      userId: (json['user_id'] as num).toInt(),
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResultToJson(
  WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult
  instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': ?instance.refreshToken,
  'user_id': instance.userId,
};
