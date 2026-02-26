// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resp_blog_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogContentResponse _$BlogContentResponseFromJson(Map<String, dynamic> json) =>
    BlogContentResponse(
      prev: json['prev'] == null
          ? null
          : BlogContentItem.fromJson(json['prev'] as Map<String, dynamic>),
      cur: BlogContentItem.fromJson(json['cur'] as Map<String, dynamic>),
      next: json['next'] == null
          ? null
          : BlogContentItem.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogContentResponseToJson(
  BlogContentResponse instance,
) => <String, dynamic>{
  'prev': instance.prev,
  'cur': instance.cur,
  'next': instance.next,
};

BlogContentItem _$BlogContentItemFromJson(Map<String, dynamic> json) =>
    BlogContentItem(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      categoryID: json['categoryID'] as String?,
      category: json['category'] as String?,
      banner: json['banner'] as String?,
      composition: json['composition'] as String,
      description: json['description'] as String?,
      addtime: json['addtime'] as String,
      edittime: json['edittime'] as String?,
      viewnum: (json['viewnum'] as num).toInt(),
      videoSrc: json['video_src'] as String?,
      minpicUrl: json['minpic_url'] as String?,
      isShow: json['is_show'] as String?,
      isTop: json['is_top'] as String?,
      isDel: json['is_del'] as String?,
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogContentItemToJson(BlogContentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'categoryID': instance.categoryID,
      'category': instance.category,
      'banner': instance.banner,
      'composition': instance.composition,
      'description': instance.description,
      'addtime': instance.addtime,
      'edittime': instance.edittime,
      'viewnum': instance.viewnum,
      'video_src': instance.videoSrc,
      'minpic_url': instance.minpicUrl,
      'is_show': instance.isShow,
      'is_top': instance.isTop,
      'is_del': instance.isDel,
      'comment': instance.comment,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => CommentItem(
  ip: json['ip'] as String,
  aId: (json['a_id'] as num).toInt(),
  tId: (json['t_id'] as num).toInt(),
  time: json['time'] as String,
  user: json['user'] as String,
  isDel: json['is_del'] as String,
  comment: json['comment'] as String,
);

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'a_id': instance.aId,
      't_id': instance.tId,
      'time': instance.time,
      'user': instance.user,
      'is_del': instance.isDel,
      'comment': instance.comment,
    };
