// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_grafana_admin_view_view_user_bought_get_view_user_bought_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult
_$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult(
      boughtList: (json['bought_list'] as List<dynamic>)
          .map((e) => ResultBought.fromJson(e as Map<String, dynamic>))
          .toList(),
      shopList: (json['shop_list'] as List<dynamic>)
          .map((e) => ResultShop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResultToJson(
  WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult
  instance,
) => <String, dynamic>{
  'bought_list': instance.boughtList,
  'shop_list': instance.shopList,
};
