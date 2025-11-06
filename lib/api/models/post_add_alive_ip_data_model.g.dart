// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_add_alive_ip_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAddAliveIpDataModel _$PostAddAliveIpDataModelFromJson(
  Map<String, dynamic> json,
) => PostAddAliveIpDataModel(
  userId: (json['user_id'] as num).toInt(),
  ip: json['ip'] as String,
);

Map<String, dynamic> _$PostAddAliveIpDataModelToJson(
  PostAddAliveIpDataModel instance,
) => <String, dynamic>{'user_id': instance.userId, 'ip': instance.ip};
