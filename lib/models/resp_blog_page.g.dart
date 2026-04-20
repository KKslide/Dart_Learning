// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resp_blog_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogResponse _$BlogResponseFromJson(Map<String, dynamic> json) => BlogResponse(
  catList: (json['catList'] as List<dynamic>)
      .map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList(),
  blogList: (json['blogList'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => BlogItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
);

Map<String, dynamic> _$BlogResponseToJson(BlogResponse instance) =>
    <String, dynamic>{
      'catList': instance.catList,
      'blogList': instance.blogList,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  showType: json['show_type'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'show_type': instance.showType,
};

BlogItem _$BlogItemFromJson(Map<String, dynamic> json) => BlogItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  categoryName: json['category'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
  description: json['description'] as String,
  createdAt: json['created_at'] as String,
  viewCount: (json['view_count'] as num).toInt(),
  coverUrl: json['cover_url'] as String?,
  isPinned: (json['is_pinned'] as num).toInt(),
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  commentNum: (json['comment_num'] as num).toInt(),
);

Map<String, dynamic> _$BlogItemToJson(BlogItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.categoryName,
  'category_id': instance.categoryId,
  'description': instance.description,
  'created_at': instance.createdAt,
  'view_count': instance.viewCount,
  'cover_url': instance.coverUrl,
  'is_pinned': instance.isPinned,
  'sort_order': instance.sortOrder,
  'comment_num': instance.commentNum,
};
