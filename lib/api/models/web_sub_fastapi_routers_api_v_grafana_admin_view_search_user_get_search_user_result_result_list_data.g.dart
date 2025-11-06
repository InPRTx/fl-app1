// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_grafana_admin_view_search_user_get_search_user_result_result_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
_$WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListDataFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      userName: json['user_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      moneyAmount: json['money_amount'] as String? ?? '0.00',
      isEnable: json['is_enable'] as bool? ?? true,
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListDataToJson(
  WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
  instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_name': instance.userName,
  'email': instance.email,
  'money_amount': instance.moneyAmount,
  'created_at': instance.createdAt.toIso8601String(),
  'is_enable': instance.isEnable,
};
