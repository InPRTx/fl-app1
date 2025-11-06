// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'share_account.dart';

part 'web_sub_fastapi_routers_api_v_user_services_share_account_user_services_share_account_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult {
  const WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult({
    required this.totalAccounts,
    required this.availableAccounts,
  });

  factory WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResultFromJson(
        json,
      );

  /// 共享账户总数
  @JsonKey(name: 'total_accounts')
  final int totalAccounts;

  /// 可用共享账户列表
  @JsonKey(name: 'available_accounts')
  final List<ShareAccount> availableAccounts;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserServicesShareAccountUserServicesShareAccountResponseResultToJson(
        this,
      );
}
