// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRegisterResponse _$AuthRegisterResponseFromJson(
  Map<String, dynamic> json,
) => AuthRegisterResponse(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$AuthRegisterResponseToJson(
  AuthRegisterResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
