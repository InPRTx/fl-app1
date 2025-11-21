// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ticket_status_enum.dart';

part 'user_ticket.g.dart';

/// 用户工单/支持单模型
@JsonSerializable()
class UserTicket {
  const UserTicket({
    required this.title,
    this.ticketStatus = TicketStatusEnum.pending,
    this.isMarkdown = true,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory UserTicket.fromJson(Map<String, Object?> json) =>
      _$UserTicketFromJson(json);

  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(includeIfNull: false, name: 'user_id')
  final int? userId;
  final String title;
  @JsonKey(name: 'ticket_status')
  final TicketStatusEnum ticketStatus;
  @JsonKey(name: 'is_markdown')
  final bool isMarkdown;

  Map<String, Object?> toJson() => _$UserTicketToJson(this);
}
