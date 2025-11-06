// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_add_detect_log_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAddDetectLogDataModel _$PostAddDetectLogDataModelFromJson(
  Map<String, dynamic> json,
) => PostAddDetectLogDataModel(
  userId: (json['user_id'] as num).toInt(),
  listId: (json['list_id'] as num).toInt(),
);

Map<String, dynamic> _$PostAddDetectLogDataModelToJson(
  PostAddDetectLogDataModel instance,
) => <String, dynamic>{'user_id': instance.userId, 'list_id': instance.listId};
