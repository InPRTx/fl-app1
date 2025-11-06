// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_services_old_index_user_services_old_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult
_$WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult(
  totalCount: (json['total_count'] as num).toInt(),
  services: (json['services'] as List<dynamic>)
      .map((e) => ServiceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResultToJson(
  WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult
  instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'services': instance.services,
};
