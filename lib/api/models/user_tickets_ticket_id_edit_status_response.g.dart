// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tickets_ticket_id_edit_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTicketsTicketIdEditStatusResponse
_$UserTicketsTicketIdEditStatusResponseFromJson(Map<String, dynamic> json) =>
    UserTicketsTicketIdEditStatusResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserTicketsTicketIdEditStatusResponseToJson(
  UserTicketsTicketIdEditStatusResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
