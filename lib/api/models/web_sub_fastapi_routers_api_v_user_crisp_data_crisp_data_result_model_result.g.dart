// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_crisp_data_crisp_data_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult
_$WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult(
  userEmail: json['user_email'] as String,
  userNickname: json['user_nickname'] as String,
  sessionData: (json['session_data'] as List<dynamic>)
      .map((e) => e as List<dynamic>)
      .toList(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResultToJson(
  WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult instance,
) => <String, dynamic>{
  'user_email': instance.userEmail,
  'user_nickname': instance.userNickname,
  'session_data': instance.sessionData,
};
