// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_tickets_ticket_id_messages_get_response.g.dart';

@JsonSerializable()
class UserTicketsTicketIdMessagesGetResponse {
  const UserTicketsTicketIdMessagesGetResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserTicketsTicketIdMessagesGetResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserTicketsTicketIdMessagesGetResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 工单消息列表
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserTicketsTicketIdMessagesGetResponseToJson(this);
}
