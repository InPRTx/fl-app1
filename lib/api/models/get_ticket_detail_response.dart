// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_ticket_view.dart';

part 'get_ticket_detail_response.g.dart';

@JsonSerializable()
class GetTicketDetailResponse {
  const GetTicketDetailResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetTicketDetailResponse.fromJson(Map<String, Object?> json) =>
      _$GetTicketDetailResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 工单详情
  @JsonKey(includeIfNull: false)
  final UserTicketView? result;

  Map<String, Object?> toJson() => _$GetTicketDetailResponseToJson(this);
}
