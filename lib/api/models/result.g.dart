// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  walletBalance: json['wallet_balance'] as String,
  inviteBalance: json['invite_balance'] as String? ?? '0.00',
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'wallet_balance': instance.walletBalance,
  'invite_balance': instance.inviteBalance,
};
