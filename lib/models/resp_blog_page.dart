import 'package:json_annotation/json_annotation.dart';

part 'resp_blog_page.g.dart';

@JsonSerializable()
class BlogResponse {
  final List<Category> catList;

  /// blogList 是一个 Map，key 是分类名(如 "Code", "Blog")，value 是博客列表
  final Map<String, List<BlogItem>> blogList;

  BlogResponse({required this.catList, required this.blogList});

  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}

/// 分类模型
@JsonSerializable()
class Category {
  final int id;
  final String name;
  @JsonKey(name: 'show_type')
  final String showType;

  Category({required this.id, required this.name, required this.showType});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

/// 博客条目模型
@JsonSerializable()
class BlogItem {
  final int id;
  final String title;
  @JsonKey(name: 'category')
  final String? categoryName;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  final String description;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'view_count')
  final int viewCount;

  @JsonKey(name: 'cover_url')
  final String? coverUrl;

  @JsonKey(name: 'is_pinned')
  final int isPinned;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'comment_num')
  final int commentNum;

  BlogItem({
    required this.id,
    required this.title,
    this.categoryName,
    this.categoryId,
    required this.description,
    required this.createdAt,
    required this.viewCount,
    this.coverUrl,
    required this.isPinned,
    this.sortOrder,
    required this.commentNum,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) =>
      _$BlogItemFromJson(json);

  Map<String, dynamic> toJson() => _$BlogItemToJson(this);

  // 辅助方法: 判断是否置顶
  bool get isTopBlog => isPinned == 1;
}
