// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_services_share_account_user_services_share_account_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult
_$WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult(
      totalAccounts: (json['total_accounts'] as num).toInt(),
      availableAccounts: (json['available_accounts'] as List<dynamic>)
          .map((e) => ShareAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResultToJson(
  WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult
  instance,
) => <String, dynamic>{
  'total_accounts': instance.totalAccounts,
  'available_accounts': instance.availableAccounts,
};
