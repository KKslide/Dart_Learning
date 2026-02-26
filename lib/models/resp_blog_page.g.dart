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
  show_type: json['show_type'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'show_type': instance.show_type,
};

BlogItem _$BlogItemFromJson(Map<String, dynamic> json) => BlogItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  category: json['category'] as String,
  description: json['description'] as String,
  addtime: json['addtime'] as String,
  viewnum: (json['viewnum'] as num).toInt(),
  minpicUrl: json['minpic_url'] as String,
  isTop: json['is_top'] as String,
  rankIndex: (json['rank_index'] as num).toInt(),
  commentNum: (json['comment_num'] as num).toInt(),
);

Map<String, dynamic> _$BlogItemToJson(BlogItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'description': instance.description,
  'addtime': instance.addtime,
  'viewnum': instance.viewnum,
  'minpic_url': instance.minpicUrl,
  'is_top': instance.isTop,
  'rank_index': instance.rankIndex,
  'comment_num': instance.commentNum,
};
