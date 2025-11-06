// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'trial_plan_model.dart';

part 'web_sub_fastapi_routers_api_v_user_shop_old_index_user_shop_old_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult {
  const WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult({
    required this.products,
  });

  factory WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResultFromJson(
        json,
      );

  /// 商品列表
  final Map<String, TrialPlanModel> products;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResultToJson(
        this,
      );
}
