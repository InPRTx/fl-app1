// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementResponse _$AnnouncementResponseFromJson(
  Map<String, dynamic> json,
) => AnnouncementResponse(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$AnnouncementResponseToJson(
  AnnouncementResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
