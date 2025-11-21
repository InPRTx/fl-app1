// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ticket_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTicketListResponse _$GetTicketListResponseFromJson(
  Map<String, dynamic> json,
) => GetTicketListResponse(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map((e) => UserTicket.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GetTicketListResponseToJson(
  GetTicketListResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
