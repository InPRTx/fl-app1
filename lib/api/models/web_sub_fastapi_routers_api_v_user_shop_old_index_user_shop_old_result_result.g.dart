// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_shop_old_index_user_shop_old_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult
_$WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult(
  products: (json['products'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, TrialPlanModel.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResultToJson(
  WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult instance,
) => <String, dynamic>{'products': instance.products};
