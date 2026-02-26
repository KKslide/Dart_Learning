import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/api/blog_api.dart';
import 'package:flutter_application/models/resp_blog_page.dart';
import 'package:flutter_application/config/config.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_application/extensions/date_extension.dart';
import 'package:flutter_application/routes/routes.gr.dart';

@RoutePage()
class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BlogResponse? _blogResponse;
  String? _selectedCategory;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBlogData();
  }

  Future<void> _loadBlogData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await BlogApi.getBlogPage();

      setState(() {
        _blogResponse = response;
        // 默认选中 TOP 分类
        if (response.blogList.containsKey('TOP')) {
          _selectedCategory = 'TOP';
        } else if (response.catList.isNotEmpty) {
          _selectedCategory = response.catList.first.name;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Category? get _currentCategory {
    if (_blogResponse == null || _selectedCategory == null) return null;
    // 如果是 TOP 分类, 尝试从 catList 中查找, 如果找不到则返回一个默认的 Category
    if (_selectedCategory == 'TOP') {
      try {
        return _blogResponse!.catList.firstWhere(
          (cat) => cat.name == 'TOP',
        );
      } catch (e) {
        // 如果 TOP 不在 catList 中, 返回一个默认的 Category (使用图文布局)
        return Category(id: 0, name: 'TOP', show_type: '2');
      }
    }
    return _blogResponse!.catList.firstWhere(
      (cat) => cat.name == _selectedCategory,
      orElse: () => _blogResponse!.catList.first,
    );
  }

  List<BlogItem> get _currentBlogList {
    if (_blogResponse == null || _selectedCategory == null) return [];
    return _blogResponse!.blogList[_selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading Error::: $_error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadBlogData,
                    child: const Text('重试'),
                  ),
                ],
              ),
            )
          : _blogResponse == null
          ? const Center(child: Text('暂无数据'))
          : SafeArea(
              child: Stack(
                children: [
                  // 内容区域放底层，预留顶部空间给搜索和分类（56 + 50 = 106）
                  Padding(
                    padding: EdgeInsets.only(top: 106.h, bottom: 50.h),
                    child: _buildContent(),
                  ),

                  // 顶部搜索栏 + 分类（覆盖在内容上方，分类的阴影会盖住内容）
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        _buildSearchBar(),
                        _buildCategoryTabs(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 8.w, 0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Content Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              onSubmitted: (value) {
                print('搜索内容: $value');
              },
              onTap: () {
                print('点击搜索框');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    if (_blogResponse == null) return const SizedBox.shrink();

    // 检查是否有 TOP 分类的数据
    final hasTopCategory = _blogResponse!.blogList.containsKey('TOP');
    final totalTabs = hasTopCategory ? _blogResponse!.catList.length + 1 : _blogResponse!.catList.length;

    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.grey[300]!,
          blurRadius: 4.r,
          offset: Offset(0, 2.h),
        )]
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: totalTabs,
        itemBuilder: (context, index) {
          String categoryName;
          if (hasTopCategory && index == 0) {
            // 第一个标签是 TOP
            categoryName = 'TOP';
          } else {
            // 其他标签从 catList 中获取
            final catIndex = hasTopCategory ? index - 1 : index;
            categoryName = _blogResponse!.catList[catIndex].name;
          }

          final isSelected = _selectedCategory == categoryName;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = categoryName;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    final category = _currentCategory;
    if (category == null) return const Center(child: Text('请选择分类'));

    final showType = category.show_type;
    final blogList = _currentBlogList;

    if (blogList.isEmpty) {
      return const Center(child: Text('暂无内容'));
    }

    switch (showType) {
      case '1':
        return _buildSimpleLayout(blogList);
      case '2':
        return _buildImageTextLayout(blogList);
      case '3':
        return _buildWaterfallLayout(blogList);
      default:
        return _buildSimpleLayout(blogList);
    }
  }

  // 1-简单布局: 纯文本列表
  Widget _buildSimpleLayout(List<BlogItem> blogList) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      itemCount: blogList.length,
      itemBuilder: (context, index) {
        final blog = blogList[index];
        return GestureDetector(
          onTap: () {
            context.router.push(ContentRoute(contentId: blog.id));
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 12.h),
            color: Colors.white,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 左侧文字内容 (60%)
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (blog.isTopBlog)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'Pinned',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              if (blog.isTopBlog) SizedBox(width: 8.w),
                              Text(
                                blog.addtime.formatDate('yyyy-MM-dd HH:mm:ss'),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            blog.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (blog.description.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Text(
                              blog.description,
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 16.sp,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${blog.viewnum}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Icon(Icons.comment, size: 16.sp, color: Colors.grey[600]),
                              SizedBox(width: 4.w),
                              Text(
                                '${blog.commentNum}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Icon(Icons.label, size: 16.sp, color: Colors.grey[600]),
                              SizedBox(width: 4.w),
                              Text(
                                blog.category,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 右侧图片 (40%)
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w, top: 16.w, bottom: 16.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          blog.minpicUrl.startsWith('http://') ||
                                  blog.minpicUrl.startsWith('https://')
                              ? blog.minpicUrl
                              : '${Config.baseUrl}${blog.minpicUrl}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 2-图文布局: 左侧图片, 右侧文字
  Widget _buildImageTextLayout(List<BlogItem> blogList) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      itemCount: blogList.length,
      itemBuilder: (context, index) {
        final blog = blogList[index];
        return GestureDetector(
          onTap: () {
            context.router.push(ContentRoute(contentId: blog.id));
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 12.h),
            color: Colors.white,
            child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,  // 拉伸子元素
              children: [
                // 左侧图片
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                  child: Image.network(
                    blog.minpicUrl.startsWith('http://') ||
                            blog.minpicUrl.startsWith('https://')
                        ? blog.minpicUrl
                        : '${Config.baseUrl}${blog.minpicUrl}',
                    width: 160.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 160.w,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                // 右侧文字
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (blog.isTopBlog)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  'Pinned',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            if (blog.isTopBlog) SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                blog.addtime.formatDate('yyyy-MM-dd HH:mm:ss'),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          blog.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (blog.description.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Text(
                            blog.description,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 14.sp,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${blog.viewnum}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Icon(
                              Icons.comment,
                              size: 14.sp,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${blog.commentNum}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.label,
                              size: 14.sp,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              blog.category,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
        );
      },
    );
  }

  // 3-瀑布流布局: 两列网格, 类似小红书的高低错落效果
  Widget _buildWaterfallLayout(List<BlogItem> blogList) {
    return MasonryGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      crossAxisCount: 2,
      mainAxisSpacing: 2.h,
      crossAxisSpacing: 2.w,
      itemCount: blogList.length,
      itemBuilder: (context, index) {
        final blog = blogList[index];
        // 根据索引生成 150-200 之间的随机高度, 创造高低差效果
        // 使用索引确保每次渲染时高度一致
        final imageHeight = 150.h + (index % 6) * 10.h; // 150, 160, 170, 180, 190, 200 循环
        
        return GestureDetector(
          onTap: () {
            context.router.push(ContentRoute(contentId: blog.id));
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            color: Colors.white,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 图片 - 使用固定高度但根据内容变化
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                    child: Image.network(
                      blog.minpicUrl.startsWith('http://') ||
                              blog.minpicUrl.startsWith('https://')
                          ? blog.minpicUrl
                          : '${Config.baseUrl}${blog.minpicUrl}',
                      width: double.infinity,
                      height: imageHeight,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: imageHeight,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                  if (blog.isTopBlog)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Pinned',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // 文字内容 - 自适应高度
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      blog.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (blog.description.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        blog.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${blog.viewnum}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.comment,
                          size: 12.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${blog.commentNum}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      blog.addtime.formatDate('yyyy-MM-dd HH:mm:ss'),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        );
      },
    );
  }
}
