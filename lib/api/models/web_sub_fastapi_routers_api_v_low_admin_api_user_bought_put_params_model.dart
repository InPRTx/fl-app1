// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_bought_put_params_model.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel {
  const WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel({
    required this.shopId,
    required this.createdAt,
    required this.moneyAmount,
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModelFromJson(
    json,
  );

  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'money_amount')
  final dynamic moneyAmount;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModelToJson(this);
}
