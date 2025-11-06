// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_tickets_ticket_id_edit_status_response.g.dart';

@JsonSerializable()
class UserTicketsTicketIdEditStatusResponse {
  const UserTicketsTicketIdEditStatusResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserTicketsTicketIdEditStatusResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserTicketsTicketIdEditStatusResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 编辑结果
  final String message;

  /// 工单状态信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserTicketsTicketIdEditStatusResponseToJson(this);
}
