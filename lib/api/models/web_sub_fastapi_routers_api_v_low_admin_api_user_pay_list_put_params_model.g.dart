// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_pay_list_put_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel
_$WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModelFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel(
  moneyAmount: json['money_amount'],
  isFinish: json['is_finish'] as bool,
  tradeNo: json['trade_no'] as String,
  payMethodId: (json['pay_method_id'] as num).toInt(),
  invoiceId: json['invoice_id'] as String?,
  remark: json['remark'] as String?,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModelToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel instance,
) => <String, dynamic>{
  'money_amount': instance.moneyAmount,
  'is_finish': instance.isFinish,
  'trade_no': instance.tradeNo,
  'pay_method_id': instance.payMethodId,
  'invoice_id': instance.invoiceId,
  'remark': instance.remark,
};
