import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/api/blog_api.dart';
import 'package:flutter_application/models/resp_blog_page.dart';
import 'package:flutter_application/config/config.dart';
import 'package:flutter_application/extensions/date_extension.dart';
import 'package:flutter_application/routes/routes.gr.dart';

/// 搜索文章列表页
/// 展示 GET /api/user/articles/search 返回的扁平列表
@RoutePage()
class SearchResultPage extends StatefulWidget {
  /// 搜索关键词（可选，不传则展示全部已发布文章）
  final String? keyword;

  const SearchResultPage({super.key, this.keyword});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _searchController = TextEditingController();

  /// 搜索结果列表
  List<BlogItem> _results = [];

  /// 是否正在加载
  bool _isLoading = false;

  /// 错误信息
  String? _error;

  /// 总记录数（取自首条记录的 total 字段，整个结果集相同）
  int _totalCount = 0;

  /// 当前页码
  int _pageNo = 1;

  /// 每页条数
  static const int _pageSize = 20;

  /// 是否已加载全部
  bool get _hasMore => _results.length < _totalCount;

  @override
  void initState() {
    super.initState();
    // 如果传入了关键词，回填到搜索框
    if (widget.keyword != null && widget.keyword!.isNotEmpty) {
      _searchController.text = widget.keyword!;
    }
    _doSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 执行搜索（pageNo=1 重置列表）
  Future<void> _doSearch({bool loadMore = false}) async {
    if (_isLoading) return;

    if (!loadMore) {
      _pageNo = 1;
    }

    final keyword = _searchController.text.trim();

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final items = await BlogApi.searchBlogList(
        keyword: keyword.isEmpty ? null : keyword,
        pageNo: _pageNo,
        pageSize: _pageSize,
      );

      if (!mounted) return;

      setState(() {
        if (loadMore) {
          _results.addAll(items);
        } else {
          _results = items;
        }
        // total 从首条记录读取（搜索接口每条记录都带有相同的 total）
        if (items.isNotEmpty) {
          _totalCount = items.first.total ?? 0;
        } else {
          _totalCount = 0;
        }
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// 加载更多（滚动到底部触发）
  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading) return;
    _pageNo++;
    await _doSearch(loadMore: true);
  }

  /// 点击文章跳转详情
  void _navigateToContent(int articleId) {
    context.router.push(ContentRoute(contentId: articleId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '搜索文章',
          style: TextStyle(fontSize: 18.sp),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(),

          // 内容区域
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  /// 顶部搜索输入框
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '输入关键词搜索文章标题/摘要...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _doSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              onSubmitted: (_) => _doSearch(),
            ),
          ),
          SizedBox(width: 8.w),
          // 搜索按钮
          ElevatedButton(
            onPressed: _isLoading ? null : () => _doSearch(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              '搜索',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  /// 主体内容：加载中 / 错误 / 空结果 / 结果列表
  Widget _buildBody() {
    if (_isLoading && _results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && _results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('加载失败: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _doSearch(),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64.sp, color: Colors.grey[400]),
            SizedBox(height: 16.h),
            Text(
              '暂无搜索结果',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // 结果计数
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          color: Colors.grey[100],
          child: Text(
            '共 $_totalCount 条结果',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
        ),

        // 列表
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // 滚动到底部时加载更多
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter < 50) {
                _loadMore();
              }
              return false;
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              itemCount: _results.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                // 底部加载指示器
                if (index == _results.length) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }

                return _buildSearchResultItem(_results[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 单条搜索结果卡片
  /// 布局：左侧可选封面图 + 右侧标题/摘要/元信息，点击进入详情
  Widget _buildSearchResultItem(BlogItem item) {
    return GestureDetector(
      onTap: () => _navigateToContent(item.id),
      child: Card(
        margin: EdgeInsets.only(bottom: 10.h),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧封面缩略图（如果有）
              if (item.coverUrl != null && item.coverUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.network(
                    item.coverUrl!.startsWith('http://') ||
                            item.coverUrl!.startsWith('https://')
                        ? item.coverUrl!
                        : '${Config.baseUrl}${item.coverUrl!}',
                    width: 100.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100.w,
                        height: 70.h,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),

              if (item.coverUrl != null && item.coverUrl!.isNotEmpty)
                SizedBox(width: 12.w),

              // 右侧文字
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // 摘要（如有）
                    if (item.description?.isNotEmpty == true) ...[
                      SizedBox(height: 6.h),
                      Text(
                        item.description!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    SizedBox(height: 8.h),

                    // 底部元信息：分类 + 时间 + 浏览量 + 评论数
                    Row(
                      children: [
                        // 分类标签
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            item.cateName ?? item.categoryName ?? '未分类',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        const Spacer(),
                        // 时间
                        Icon(Icons.access_time,
                            size: 12.sp, color: Colors.grey[500]),
                        SizedBox(width: 2.w),
                        Text(
                          item.createdAt.formatDate('yyyy-MM-dd'),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // 浏览量
                        Icon(Icons.visibility,
                            size: 12.sp, color: Colors.grey[500]),
                        SizedBox(width: 2.w),
                        Text(
                          '${item.viewCount}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // 评论数
                        Icon(Icons.comment,
                            size: 12.sp, color: Colors.grey[500]),
                        SizedBox(width: 2.w),
                        Text(
                          '${item.commentNum}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
