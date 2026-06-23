import 'package:flutter_application/models/resp_blog_page.dart';
import 'package:flutter_application/models/resp_blog_content.dart';
import 'package:flutter_application/models/resp_message.dart';
import 'package:flutter_application/utils/http_manager/http_manager.dart';
import 'package:flutter_application/utils/http_manager/result_data.dart';

/// 博客相关 API
class BlogApi {
  /// 获取博客列表
  /// 返回包含分类列表和博客列表的数据
  /// GET /api/user/articles → { code, msg, data: { catList, blogList } }
  static Future<BlogResponse> getBlogPage() async {
    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/articles',
    );

    if (err != null) {
      throw err;
    }

    // 新接口统一响应格式: { code, msg, data }
    // 需要从 data 字段中提取业务数据
    return BlogResponse.fromJson(result['data']);
  }

  /// 搜索文章列表
  /// GET /api/user/articles/search?keyword=&category_id=&pageNo=&pageSize=
  /// 返回扁平的文章列表（非分类分组），每条记录含 total 字段
  static Future<List<BlogItem>> searchBlogList({
    String? keyword,
    int? categoryId,
    int pageNo = 1,
    int pageSize = 20,
  }) async {
    final Map<String, dynamic> query = {
      'pageNo': pageNo,
      'pageSize': pageSize,
    };
    if (keyword != null && keyword.trim().isNotEmpty) {
      query['keyword'] = keyword.trim();
    }
    if (categoryId != null && categoryId > 0) {
      query['category_id'] = categoryId;
    }

    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/articles/search',
      query: query,
    );

    if (err != null) {
      throw err;
    }

    // 响应格式: { code, msg, data: [...] }
    final List<dynamic> dataList = result['data'] as List<dynamic>;
    return dataList
        .map((e) => BlogItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取文章内容
  /// [contentId] 文章ID
  /// GET /api/user/articles/:id → { code, msg, data: { prev, cur, next } }
  /// 返回包含当前文章、上一篇、下一篇和评论的数据
  static Future<BlogContentResponse> getBlogContent(int contentId) async {
    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/articles/$contentId',
    );

    if (err != null) {
      throw err;
    }

    // 新接口统一响应格式: { code, msg, data }
    // 需要从 data 字段中提取业务数据
    return BlogContentResponse.fromJson(result['data']);
  }

  /// 发表评论
  /// POST /api/user/articles/:id/comments
  /// 昵称由服务端根据客户端 IP 自动生成
  /// [articleId] 文章 ID
  /// [comment] 评论内容，1-500 字
  static Future<void> postComment({
    required int articleId,
    required String comment,
  }) async {
    final ResultData(result: result, err: err) = await httpManager.post(
      '/api/user/articles/$articleId/comments',
      data: {'comment': comment},
    );

    if (err != null) throw err;

    if (result['code'] != 1) {
      throw Exception(result['msg'] ?? '评论提交失败');
    }
  }

  /// 获取留言列表（不分页，返回全部）
  /// GET /api/user/messages → { code, msg, data: [...] }
  static Future<List<MessageItem>> getMessages() async {
    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/messages',
    );

    if (err != null) {
      throw err;
    }

    final List<dynamic> dataList = result['data'] as List<dynamic>;
    return dataList
        .map((e) => MessageItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 提交留言
  /// POST /api/user/messages
  /// 昵称由服务端根据客户端 IP 自动生成
  /// [content] 留言内容（必填，最多 500 字）
  static Future<void> postMessage({
    required String content,
  }) async {
    final ResultData(result: result, err: err) = await httpManager.post(
      '/api/user/messages',
      data: {'content': content},
    );

    if (err != null) throw err;

    if (result['code'] != 1) {
      throw Exception(result['msg'] ?? '留言提交失败');
    }
  }

  /// 记录文章阅读（同日同IP去重）
  /// POST /api/user/articles/:id/view
  /// 返回更新后的浏览量（无论本次是否计入，都取服务端最新 count）
  static Future<int> recordArticleView(int articleId) async {
    final ResultData(result: result, err: err) = await httpManager.post(
      '/api/user/articles/$articleId/view',
    );

    if (err != null) throw err;

    // 响应格式: { code, msg, data: { counted, view_count } }
    return (result['data']['view_count'] as num).toInt();
  }
}
