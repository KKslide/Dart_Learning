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
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryName: json['category'] as String?,
      bannerUrl: json['banner_url'] as String?,
      content: json['content'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
      viewCount: (json['view_count'] as num).toInt(),
      videoUrl: json['video_url'] as String?,
      coverUrl: json['cover_url'] as String?,
      isPublished: (json['is_published'] as num?)?.toInt(),
      isPinned: (json['is_pinned'] as num?)?.toInt(),
      isDel: (json['is_del'] as num?)?.toInt(),
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogContentItemToJson(BlogContentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category_id': instance.categoryId,
      'category': instance.categoryName,
      'banner_url': instance.bannerUrl,
      'content': instance.content,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'view_count': instance.viewCount,
      'video_url': instance.videoUrl,
      'cover_url': instance.coverUrl,
      'is_published': instance.isPublished,
      'is_pinned': instance.isPinned,
      'is_del': instance.isDel,
      'comment': instance.comment,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => CommentItem(
  ip: json['ip'] as String,
  articleId: (json['articleId'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  createdAt: json['created_at'] as String,
  nickname: json['nickname'] as String,
  isDel: (json['is_del'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'articleId': instance.articleId,
      'id': instance.id,
      'created_at': instance.createdAt,
      'nickname': instance.nickname,
      'is_del': instance.isDel,
      'content': instance.content,
    };
