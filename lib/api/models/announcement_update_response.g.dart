// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementUpdateResponse _$AnnouncementUpdateResponseFromJson(
  Map<String, dynamic> json,
) => AnnouncementUpdateResponse(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$AnnouncementUpdateResponseToJson(
  AnnouncementUpdateResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
