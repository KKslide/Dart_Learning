// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable_trial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  emailUrl: json['email_url'] as String?,
  isActive: json['isActive'] as bool? ?? false,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'email_url': instance.emailUrl,
  'isActive': instance.isActive,
};
