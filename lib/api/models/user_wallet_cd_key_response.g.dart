// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet_cd_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletCdKeyResponse _$UserWalletCdKeyResponseFromJson(
  Map<String, dynamic> json,
) => UserWalletCdKeyResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserWalletCdKeyResponseToJson(
  UserWalletCdKeyResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
