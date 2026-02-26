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
  final String show_type;

  Category({required this.id, required this.name, required this.show_type});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

/// 博客条目模型
@JsonSerializable()
class BlogItem {
  final int id;
  final String title;
  final String category;
  final String description;
  final String addtime;
  final int viewnum;

  @JsonKey(name: 'minpic_url')
  final String minpicUrl;

  @JsonKey(name: 'is_top')
  final String isTop;

  @JsonKey(name: 'rank_index')
  final int rankIndex;

  @JsonKey(name: 'comment_num')
  final int commentNum;

  BlogItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.addtime,
    required this.viewnum,
    required this.minpicUrl,
    required this.isTop,
    required this.rankIndex,
    required this.commentNum,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) =>
      _$BlogItemFromJson(json);

  Map<String, dynamic> toJson() => _$BlogItemToJson(this);

  // 辅助方法: 判断是否置顶
  bool get isTopBlog => isTop == '1';
}
