// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_v_get_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketVGetResultModel _$TicketVGetResultModelFromJson(
  Map<String, dynamic> json,
) => TicketVGetResultModel(
  result:
      WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$TicketVGetResultModelToJson(
  TicketVGetResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
