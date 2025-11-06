// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tickets_ticket_id_messages_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTicketsTicketIdMessagesPostResponse
_$UserTicketsTicketIdMessagesPostResponseFromJson(Map<String, dynamic> json) =>
    UserTicketsTicketIdMessagesPostResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserTicketsTicketIdMessagesPostResponseToJson(
  UserTicketsTicketIdMessagesPostResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
