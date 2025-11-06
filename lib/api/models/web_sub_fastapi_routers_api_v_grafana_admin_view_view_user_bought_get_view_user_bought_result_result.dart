// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'result_bought.dart';
import 'result_shop.dart';

part 'web_sub_fastapi_routers_api_v_grafana_admin_view_view_user_bought_get_view_user_bought_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult {
  const WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult({
    required this.boughtList,
    required this.shopList,
  });

  factory WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResultFromJson(
        json,
      );

  @JsonKey(name: 'bought_list')
  final List<ResultBought> boughtList;
  @JsonKey(name: 'shop_list')
  final List<ResultShop> shopList;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserBoughtGetViewUserBoughtResultResultToJson(
        this,
      );
}
