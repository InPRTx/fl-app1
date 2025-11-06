// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_add_alive_ip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAddAliveIpModel _$PostAddAliveIpModelFromJson(Map<String, dynamic> json) =>
    PostAddAliveIpModel(
      data: (json['data'] as List<dynamic>)
          .map(
            (e) => PostAddAliveIpDataModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$PostAddAliveIpModelToJson(
  PostAddAliveIpModel instance,
) => <String, dynamic>{'data': instance.data};
