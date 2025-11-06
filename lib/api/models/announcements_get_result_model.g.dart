// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_get_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementsGetResultModel _$AnnouncementsGetResultModelFromJson(
  Map<String, dynamic> json,
) => AnnouncementsGetResultModel(
  result:
      WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$AnnouncementsGetResultModelToJson(
  AnnouncementsGetResultModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
