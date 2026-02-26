// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_builder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorBuilder _$ErrorBuilderFromJson(Map<String, dynamic> json) => ErrorBuilder(
  msg: json['msg'] as String,
  code: (json['code'] as num).toInt(),
  more: json['more'],
);

Map<String, dynamic> _$ErrorBuilderToJson(ErrorBuilder instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'more': instance.more,
    };
