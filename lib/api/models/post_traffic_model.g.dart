// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_traffic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTrafficModel _$PostTrafficModelFromJson(Map<String, dynamic> json) =>
    PostTrafficModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => PostTrafficDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostTrafficModelToJson(PostTrafficModel instance) =>
    <String, dynamic>{'data': instance.data};
