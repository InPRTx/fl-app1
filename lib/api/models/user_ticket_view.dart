// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'messages.dart';
import 'ticket_status_enum.dart';

part 'user_ticket_view.g.dart';

@JsonSerializable()
class UserTicketView {
  const UserTicketView({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.title,
    required this.ticketStatus,
    required this.isMarkdown,
    this.messages,
    this.userIds,
  });

  factory UserTicketView.fromJson(Map<String, Object?> json) =>
      _$UserTicketViewFromJson(json);

  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'user_id')
  final int userId;
  final String title;
  @JsonKey(name: 'ticket_status')
  final TicketStatusEnum ticketStatus;
  @JsonKey(name: 'is_markdown')
  final bool isMarkdown;
  @JsonKey(includeIfNull: false)
  final List<Messages>? messages;
  @JsonKey(includeIfNull: false, name: 'user_ids')
  final List<int>? userIds;

  Map<String, Object?> toJson() => _$UserTicketViewToJson(this);
}
