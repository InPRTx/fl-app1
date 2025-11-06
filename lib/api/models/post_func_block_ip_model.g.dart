// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_func_block_ip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFuncBlockIpModel _$PostFuncBlockIpModelFromJson(
  Map<String, dynamic> json,
) => PostFuncBlockIpModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => PostFuncBlockIpDataModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PostFuncBlockIpModelToJson(
  PostFuncBlockIpModel instance,
) => <String, dynamic>{'data': instance.data};
