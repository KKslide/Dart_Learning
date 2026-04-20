import 'package:json_annotation/json_annotation.dart';

part 'resp_blog_content.g.dart';

@JsonSerializable()
class BlogContentResponse {
  final BlogContentItem? prev;
  final BlogContentItem cur;
  final BlogContentItem? next;

  BlogContentResponse({this.prev, required this.cur, this.next});

  factory BlogContentResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogContentResponseToJson(this);
}

@JsonSerializable()
class BlogContentItem {
  final int id;
  final String title;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(name: 'category')
  final String? categoryName;
  @JsonKey(name: 'banner_url')
  final String? bannerUrl;
  final String content;
  final String? description;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'view_count')
  final int viewCount;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @JsonKey(name: 'is_published')
  final int? isPublished;
  @JsonKey(name: 'is_pinned')
  final int? isPinned;
  @JsonKey(name: 'is_del')
  final int? isDel;
  final List<CommentItem>? comment;

  BlogContentItem({
    required this.id,
    required this.title,
    this.categoryId,
    this.categoryName,
    this.bannerUrl,
    required this.content,
    this.description,
    required this.createdAt,
    this.updatedAt,
    required this.viewCount,
    this.videoUrl,
    this.coverUrl,
    this.isPublished,
    this.isPinned,
    this.isDel,
    this.comment,
  });

  factory BlogContentItem.fromJson(Map<String, dynamic> json) =>
      _$BlogContentItemFromJson(json);

  Map<String, dynamic> toJson() => _$BlogContentItemToJson(this);
}

@JsonSerializable()
class CommentItem {
  final String ip;
  final int articleId;
  final int id;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String nickname;
  @JsonKey(name: 'is_del')
  final int isDel;
  final String content;

  CommentItem({
    required this.ip,
    required this.articleId,
    required this.id,
    required this.createdAt,
    required this.nickname,
    required this.isDel,
    required this.content,
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}
