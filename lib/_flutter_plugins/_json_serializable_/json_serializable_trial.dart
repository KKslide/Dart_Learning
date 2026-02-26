import 'package:json_annotation/json_annotation.dart';

part 'json_serializable_trial.g.dart';

// jmodel 是快速创建模版的命令, 已经写在vscode代码段里面了
/* 
  @JsonSerializable(createToJson: true)  // 生成 toJson 方法
  @JsonSerializable(createToJson: false) // 不生成 toJson 方法
  @JsonSerializable(
    createFactory: true,    // 是否生成 fromJson (默认 true)
    createToJson: true,     // 是否生成 toJson (默认 true)
    explicitToJson: false,  // 嵌套对象是否调用 toJson (默认 false)
    includeIfNull: true,    // 是否包含 null 值字段 (默认 true)
    fieldRename: FieldRename.none, // 字段命名转换规则
  )
*/

@JsonSerializable()
class UserInfo {
  final String name;
  final int age;

  @JsonKey(name: 'email_url') // 字段映射名
  final String? emailUrl;

  @JsonKey(includeFromJson: false) // 忽略此字段
  final String password;

  @JsonKey(defaultValue: false) // 默认值
  final bool isActive;

  UserInfo({
    required this.name, 
    required this.age, 
    this.emailUrl,
    this.password = '',
    this.isActive = false,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
