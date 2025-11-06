// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_traffic_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTrafficDataModel _$PostTrafficDataModelFromJson(
  Map<String, dynamic> json,
) => PostTrafficDataModel(
  userId: (json['user_id'] as num).toInt(),
  u: (json['u'] as num).toInt(),
  d: (json['d'] as num).toInt(),
);

Map<String, dynamic> _$PostTrafficDataModelToJson(
  PostTrafficDataModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'u': instance.u,
  'd': instance.d,
};
