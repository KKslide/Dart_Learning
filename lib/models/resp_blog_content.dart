import 'package:json_annotation/json_annotation.dart';

part 'resp_blog_content.g.dart';

@JsonSerializable()
class BlogContentResponse {
  final BlogContentItem? prev;
  final BlogContentItem cur;
  final BlogContentItem? next;

  BlogContentResponse({
    this.prev,
    required this.cur,
    this.next,
  });

  factory BlogContentResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogContentResponseToJson(this);
}

@JsonSerializable()
class BlogContentItem {
  final int id;
  final String title;
  
  @JsonKey(name: 'categoryID')
  final String? categoryID;
  
  final String? category;
  final String? banner;
  final String composition;
  final String? description;
  final String addtime;
  final String? edittime;
  final int viewnum;
  
  @JsonKey(name: 'video_src')
  final String? videoSrc;
  
  @JsonKey(name: 'minpic_url')
  final String? minpicUrl;
  
  @JsonKey(name: 'is_show')
  final String? isShow;
  
  @JsonKey(name: 'is_top')
  final String? isTop;
  
  @JsonKey(name: 'is_del')
  final String? isDel;
  
  final List<CommentItem>? comment;

  BlogContentItem({
    required this.id,
    required this.title,
    this.categoryID,
    this.category,
    this.banner,
    required this.composition,
    this.description,
    required this.addtime,
    this.edittime,
    required this.viewnum,
    this.videoSrc,
    this.minpicUrl,
    this.isShow,
    this.isTop,
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
  
  @JsonKey(name: 'a_id')
  final int aId;
  
  @JsonKey(name: 't_id')
  final int tId;
  
  final String time;
  final String user;
  
  @JsonKey(name: 'is_del')
  final String isDel;
  
  final String comment;

  CommentItem({
    required this.ip,
    required this.aId,
    required this.tId,
    required this.time,
    required this.user,
    required this.isDel,
    required this.comment,
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}
