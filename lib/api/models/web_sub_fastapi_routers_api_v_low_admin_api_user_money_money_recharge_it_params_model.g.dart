// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_money_money_recharge_it_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel
_$WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModelFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel(
  moneyAmountAdd: json['money_amount_add'],
  remark: json['remark'] as String?,
  isInsertPaylist: json['is_insert_paylist'] as bool? ?? true,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModelToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel
  instance,
) => <String, dynamic>{
  'money_amount_add': instance.moneyAmountAdd,
  'is_insert_paylist': instance.isInsertPaylist,
  'remark': ?instance.remark,
};
