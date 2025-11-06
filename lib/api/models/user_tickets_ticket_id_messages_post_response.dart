// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_tickets_ticket_id_messages_post_response.g.dart';

@JsonSerializable()
class UserTicketsTicketIdMessagesPostResponse {
  const UserTicketsTicketIdMessagesPostResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserTicketsTicketIdMessagesPostResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserTicketsTicketIdMessagesPostResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 发送结果
  final String message;

  /// 消息信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserTicketsTicketIdMessagesPostResponseToJson(this);
}
