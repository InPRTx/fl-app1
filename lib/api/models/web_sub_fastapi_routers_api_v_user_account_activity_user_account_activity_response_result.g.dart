// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_account_activity_user_account_activity_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult
_$WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult(
      totalCount: (json['total_count'] as num).toInt(),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => ActivityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResultToJson(
  WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult
  instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'activities': instance.activities,
};
