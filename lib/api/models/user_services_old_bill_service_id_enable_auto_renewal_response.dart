// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_old_bill_service_id_enable_auto_renewal_response.g.dart';

@JsonSerializable()
class UserServicesOldBillServiceIdEnableAutoRenewalResponse {
  const UserServicesOldBillServiceIdEnableAutoRenewalResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesOldBillServiceIdEnableAutoRenewalResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesOldBillServiceIdEnableAutoRenewalResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 自动续费设置信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserServicesOldBillServiceIdEnableAutoRenewalResponseToJson(this);
}
