// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'service_item.dart';

part 'web_sub_fastapi_routers_api_v_user_services_old_index_user_services_old_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult {
  const WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult({
    required this.totalCount,
    required this.services,
  });

  factory WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResultFromJson(
        json,
      );

  /// 服务总数
  @JsonKey(name: 'total_count')
  final int totalCount;

  /// 服务列表
  final List<ServiceItem> services;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResultToJson(
        this,
      );
}
