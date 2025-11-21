// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ticket_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTicketDetailResponse _$GetTicketDetailResponseFromJson(
  Map<String, dynamic> json,
) => GetTicketDetailResponse(
  result: json['result'] == null
      ? null
      : UserTicketView.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetTicketDetailResponseToJson(
  GetTicketDetailResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
