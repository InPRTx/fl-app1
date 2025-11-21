// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_ticket.dart';

part 'get_ticket_list_response.g.dart';

@JsonSerializable()
class GetTicketListResponse {
  const GetTicketListResponse({
    this.isSuccess = true,
    this.message = '获取成功',
    this.resultList = const [],
  });

  factory GetTicketListResponse.fromJson(Map<String, Object?> json) =>
      _$GetTicketListResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 工单视图列表
  @JsonKey(name: 'result_list')
  final List<UserTicket> resultList;

  Map<String, Object?> toJson() => _$GetTicketListResponseToJson(this);
}
