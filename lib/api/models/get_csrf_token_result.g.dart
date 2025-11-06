// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_csrf_token_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCsrfTokenResult _$GetCsrfTokenResultFromJson(Map<String, dynamic> json) =>
    GetCsrfTokenResult(
      csrfToken: json['csrf_token'] as String,
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$GetCsrfTokenResultToJson(GetCsrfTokenResult instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'csrf_token': instance.csrfToken,
    };
