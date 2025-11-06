// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_add_detect_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAddDetectLogModel _$PostAddDetectLogModelFromJson(
  Map<String, dynamic> json,
) => PostAddDetectLogModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => PostAddDetectLogDataModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PostAddDetectLogModelToJson(
  PostAddDetectLogModel instance,
) => <String, dynamic>{'data': instance.data};
