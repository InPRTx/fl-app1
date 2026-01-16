// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consume_verify_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumeVerifyTokenModel _$ConsumeVerifyTokenModelFromJson(
  Map<String, dynamic> json,
) => ConsumeVerifyTokenModel(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? false,
);

Map<String, dynamic> _$ConsumeVerifyTokenModelToJson(
  ConsumeVerifyTokenModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
