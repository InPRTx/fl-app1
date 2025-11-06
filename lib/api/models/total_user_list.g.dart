// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_user_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalUserList _$TotalUserListFromJson(Map<String, dynamic> json) =>
    TotalUserList(
      dataStartAts: (json['data_start_ats'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$TotalUserListToJson(TotalUserList instance) =>
    <String, dynamic>{
      'data_start_ats': instance.dataStartAts
          .map((e) => e.toIso8601String())
          .toList(),
    };
