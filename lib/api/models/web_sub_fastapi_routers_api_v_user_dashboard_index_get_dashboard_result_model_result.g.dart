// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_dashboard_index_get_dashboard_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult
_$WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult(
  userId: (json['user_id'] as num).toInt(),
  userNewId: json['user_new_id'] as String,
  email: json['email'] as String,
  userName: json['user_name'] as String,
  moneyAmount: json['money_amount'] as String,
  oldServiceInfo: json['old_service_info'] == null
      ? null
      : OldServiceInfo.fromJson(
          json['old_service_info'] as Map<String, dynamic>,
        ),
  tgId: (json['tg_id'] as num?)?.toInt(),
  isBan: json['is_ban'] as bool? ?? false,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResultToJson(
  WebSubFastapiRoutersApiVUserDashboardIndexGetDashboardResultModelResult
  instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_new_id': instance.userNewId,
  'email': instance.email,
  'is_ban': instance.isBan,
  'tg_id': ?instance.tgId,
  'user_name': instance.userName,
  'money_amount': instance.moneyAmount,
  'old_service_info': instance.oldServiceInfo,
};
