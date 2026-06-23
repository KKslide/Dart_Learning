import 'package:json_annotation/json_annotation.dart';

part 'resp_message.g.dart';

/// 留言板消息模型
/// 对应 GET /api/user/messages 返回的每条记录
@JsonSerializable()
class MessageItem {
  final int id;
  final String nickname;
  final String content;
  final String? ip;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'is_del')
  final int isDel;

  MessageItem({
    required this.id,
    required this.nickname,
    required this.content,
    this.ip,
    required this.createdAt,
    required this.isDel,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) =>
      _$MessageItemFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemToJson(this);

  /// 是否未被软删除
  bool get isActive => isDel == 0;
}
