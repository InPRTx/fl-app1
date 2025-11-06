// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_auth_account_login_index_login_post_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult
_$WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  userId: (json['user_id'] as num).toInt(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResultToJson(
  WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult
  instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'user_id': instance.userId,
};
