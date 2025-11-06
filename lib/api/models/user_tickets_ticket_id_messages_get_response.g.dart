// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tickets_ticket_id_messages_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTicketsTicketIdMessagesGetResponse
_$UserTicketsTicketIdMessagesGetResponseFromJson(Map<String, dynamic> json) =>
    UserTicketsTicketIdMessagesGetResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserTicketsTicketIdMessagesGetResponseToJson(
  UserTicketsTicketIdMessagesGetResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
