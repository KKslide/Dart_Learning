import 'package:flutter_application/models/resp_blog_page.dart';
import 'package:flutter_application/models/resp_blog_content.dart';
import 'package:flutter_application/utils/http_manager/http_manager.dart';
import 'package:flutter_application/utils/http_manager/result_data.dart';

/// 博客相关 API
class BlogApi {
  /// 获取博客列表
  /// 返回包含分类列表和博客列表的数据
  static Future<BlogResponse> getBlogPage() async {
    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/page',
    );

    if (err != null) {
      throw err;
    }

    return BlogResponse.fromJson(result);
  }

  /// 获取文章内容
  /// [contentId] 文章ID
  /// 返回包含当前文章、上一篇、下一篇和评论的数据
  static Future<BlogContentResponse> getBlogContent(int contentId) async {
    final ResultData(result: result, err: err) = await httpManager.post(
      '/api/user/content',
      data: {'contentid': contentId},
    );

    if (err != null) {
      throw err;
    }

    return BlogContentResponse.fromJson(result);
  }
}
