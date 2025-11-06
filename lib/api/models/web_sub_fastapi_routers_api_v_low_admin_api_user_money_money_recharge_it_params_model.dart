// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_money_money_recharge_it_params_model.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel {
  const WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel({
    required this.moneyAmountAdd,
    this.remark,
    this.isInsertPaylist = true,
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModelFromJson(
        json,
      );

  /// 充值金额
  @JsonKey(name: 'money_amount_add')
  final dynamic moneyAmountAdd;

  /// 是否显示在充值记录上
  @JsonKey(name: 'is_insert_paylist')
  final bool isInsertPaylist;

  /// 备注
  @JsonKey(includeIfNull: false)
  final String? remark;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModelToJson(
        this,
      );
}
