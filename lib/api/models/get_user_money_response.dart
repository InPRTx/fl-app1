// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'admin_user_money_model.dart';

part 'get_user_money_response.g.dart';

@JsonSerializable()
class GetUserMoneyResponse {
  const GetUserMoneyResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetUserMoneyResponse.fromJson(Map<String, Object?> json) =>
      _$GetUserMoneyResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 管理员用户信息
  @JsonKey(includeIfNull: false)
  final AdminUserMoneyModel? result;

  Map<String, Object?> toJson() => _$GetUserMoneyResponseToJson(this);
}
