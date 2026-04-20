import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/api/blog_api.dart';
import 'package:flutter_application/models/resp_blog_content.dart';
import 'package:flutter_application/config/config.dart';
import 'package:flutter_application/extensions/date_extension.dart';
import 'package:flutter_application/routes/routes.gr.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_application/widget/html_pre_code_extension.dart';
import 'package:flutter_application/widget/html_image_extension.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class ContentPage extends StatefulWidget {
  final int contentId;

  const ContentPage({super.key, required this.contentId});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  BlogContentResponse? _contentResponse;
  bool _isLoading = true;
  String? _error;
  VideoPlayerController? _videoController;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final int _maxCommentLength = 500;
  bool _isCommentFocused = false;

  @override
  void initState() {
    super.initState();
    _loadContent();
    _commentController.addListener(() {
      setState(() {});
    });
    // 监听输入框焦点变化
    _commentFocusNode.addListener(() {
      setState(() {
        _isCommentFocused = _commentFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadContent() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await BlogApi.getBlogContent(widget.contentId);
      setState(() {
        _contentResponse = response;
        _isLoading = false;
      });

      // 初始化视频播放器（如果有视频）
      if (response.cur.videoUrl != null &&
          response.cur.videoUrl!.isNotEmpty &&
          response.cur.videoUrl != 'null') {
        _initVideoPlayer(response.cur.videoUrl!);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _initVideoPlayer(String videoSrc) async {
    try {
      String videoUrl = videoSrc;
      if (!videoSrc.startsWith('http://') && !videoSrc.startsWith('https://')) {
        videoUrl = '${Config.baseUrl}$videoSrc';
      }

      _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _videoController!.initialize();

      // 添加监听器，当播放状态改变时更新 UI
      _videoController!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('视频播放器初始化失败: $e');
      // 如果初始化失败，清空控制器，这样 UI 就不会显示播放器
      _videoController?.dispose();
      _videoController = null;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _submitComment() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      return;
    }
    if (comment.length > _maxCommentLength) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('评论不能超过 $_maxCommentLength 字')));
      return;
    }

    // 暂时用 print 处理
    print('提交评论: $comment');
    _commentController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('评论已提交（调试模式）')));
  }

  void _navigateToArticle(int? articleId) {
    if (articleId == null) return;
    context.router.push(ContentRoute(contentId: articleId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('🎥 ∙ 📷'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('加载失败: $_error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadContent,
                    child: const Text('重试'),
                  ),
                ],
              ),
            )
          : _contentResponse == null
          ? const Center(child: Text('暂无数据'))
          : GestureDetector(
              onTap: () {
                // 点击外部时，如果输入框有焦点，则失焦
                if (_commentFocusNode.hasFocus) {
                  _commentFocusNode.unfocus();
                }
              },
              child: _buildContent(),
            ),
    );
  }

  // 文章内容
  Widget _buildContent() {
    final cur = _contentResponse!.cur;
    final prev = _contentResponse!.prev;
    final next = _contentResponse!.next;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner 图片（如果有）
          if (cur.bannerUrl != null && cur.bannerUrl!.isNotEmpty)
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  cur.bannerUrl!.startsWith('http://') ||
                          cur.bannerUrl!.startsWith('https://')
                      ? cur.bannerUrl!
                      : '${Config.baseUrl}${cur.bannerUrl!}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

          // 文章标题
          Text(
            cur.title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),

          // 文章元数据
          _buildMetadata(cur),
          SizedBox(height: 16.h),

          // 视频播放器（如果有）
          if (cur.videoUrl != null &&
              cur.videoUrl!.isNotEmpty &&
              cur.videoUrl != 'null')
            _buildVideoPlayer(cur),

          // HTML 内容 (预处理: 编码图片 URL 中的空格等字符, 否则网络图可能不显示)
          Html(
            data: _encodeImageUrlsInHtml(cur.content),
            extensions: const [
              CustomImageExtension(),
              PreCodeHighlightExtension(),
            ],
            style: {
              'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
              'p': Style(
                fontSize: FontSize(16.sp),
                lineHeight: const LineHeight(1.6),
                margin: Margins.only(bottom: 12.h),
              ),
              'h1': Style(
                fontSize: FontSize(22.sp),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 16.h, top: 16.h),
              ),
              'h2': Style(
                fontSize: FontSize(20.sp),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 14.h, top: 14.h),
              ),
              'h3': Style(
                fontSize: FontSize(18.sp),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 12.h, top: 12.h),
              ),
              'code': Style(
                backgroundColor: Colors.grey[200],
                padding: HtmlPaddings.all(4.w),
                whiteSpace: WhiteSpace.pre,
                fontFamily: 'monospace',
              ),
              'pre': Style(
                backgroundColor: Colors.grey[100],
                padding: HtmlPaddings.all(12.w),
                margin: Margins.only(bottom: 12.h),
                whiteSpace: WhiteSpace.pre,
                fontFamily: 'monospace',
              ),
              'img': Style(
                display: Display.block, // 设置为 block, 确保图片换行显示
                margin: Margins.zero, // 边距在 CustomImageExtension 中处理
              ),
            },
          ),
          SizedBox(height: 24.h),

          // 上一篇/下一篇导航
          _buildNavigationButtons(prev, next),
          SizedBox(height: 24.h),

          // 评论区域
          _buildCommentSection(cur),
        ],
      ),
    );
  }

  // 文章元数据
  Widget _buildMetadata(BlogContentItem item) {
    return Row(
      children: [
        Icon(Icons.visibility, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(
          '${item.viewCount}',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.comment, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(
          '${item.comment?.length ?? 0}',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.access_time, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(
          item.createdAt.formatDate('yyyy-MM-dd HH:mm:ss'),
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        if (item.categoryName != null) ...[
          SizedBox(width: 16.w),
          Icon(Icons.label, size: 16.sp, color: Colors.grey[600]),
          SizedBox(width: 4.w),
          Text(
            item.categoryName ?? '',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }

  // 上一篇/下一篇导航
  Widget _buildNavigationButtons(BlogContentItem? prev, BlogContentItem? next) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          if (prev != null)
            InkWell(
              onTap: () => _navigateToArticle(prev.id),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 16.sp,
                      color: Colors.grey[700],
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '上一篇',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            prev.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[800],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (prev != null && next != null)
            Divider(height: 1.h, color: Colors.grey[300]),
          if (next != null)
            InkWell(
              onTap: () => _navigateToArticle(next.id),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 16.sp,
                      color: Colors.grey[700],
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '下一篇',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            next.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[800],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 评论区域
  Widget _buildCommentSection(BlogContentItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '欢迎留言',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),

        // 评论输入框
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  TextField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    maxLines: 4,
                    maxLength: _maxCommentLength,
                    decoration: InputDecoration(
                      hintText: '发表你的评论...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      counterText: '', // 隐藏默认的计数器
                      contentPadding: EdgeInsets.only(
                        left: 12.w,
                        top: 12.h,
                        right: 12.w,
                        bottom: 32.h, // 为字数统计留出空间
                      ),
                    ),
                  ),
                  // 字数统计显示在右下角
                  Positioned(
                    right: 12.w,
                    bottom: 8.h,
                    child: Text(
                      '${_commentController.text.length}/$_maxCommentLength',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color:
                            _commentController.text.length > _maxCommentLength
                            ? Colors.red
                            : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: _commentController.text.trim().isEmpty
                  ? null
                  : _submitComment,
              child: Text(_isCommentFocused ? '确认' : '确定'),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        // 评论列表
        if (item.comment != null && item.comment!.isNotEmpty) ...[
          Text(
            '评论 (${item.comment!.length})',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          ...item.comment!.map((comment) => _buildCommentItem(comment)),
        ],
      ],
    );
  }

  // 评论项
  Widget _buildCommentItem(CommentItem comment) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息和时间
          Row(
            children: [
              Text(
                comment.nickname,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                comment.createdAt.formatDate('yyyy-MM-dd HH:mm:ss'),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // 评论内容
          Text(
            comment.content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// 将 HTML 中 img 标签的 src 进行编码 (如空格 -> %20), 避免带空格或特殊字符的图片 URL 无法加载
  static String _encodeImageUrlsInHtml(String html) {
    return html.replaceAllMapped(
      RegExp(r'<img\s+([^>]*)>', caseSensitive: false),
      (Match m) {
        final content = m.group(1)!;
        final newContent = content.replaceAllMapped(
          RegExp(r'\bsrc="([^"]*)"'),
          (Match m2) {
            final url = m2.group(1)!;
            final encoded = url.replaceAll(' ', '%20');
            return 'src="$encoded"';
          },
        );
        return '<img $newContent>';
      },
    );
  }

  // 构建视频播放器
  Widget _buildVideoPlayer(BlogContentItem item) {
    final isVlog = item.categoryName?.toLowerCase() == 'vlog';
    final coverUrl =
        isVlog && item.coverUrl != null && item.coverUrl!.isNotEmpty
        ? (item.coverUrl!.startsWith('http://') ||
                  item.coverUrl!.startsWith('https://')
              ? item.coverUrl!
              : '${Config.baseUrl}${item.coverUrl!}')
        : null;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          children: [
            // 视频播放器（已初始化时显示）
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_videoController!),
                    // 视频控制栏
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 进度条
                            VideoProgressIndicator(
                              _videoController!,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: Colors.red,
                                bufferedColor: Colors.grey[300]!,
                                backgroundColor: Colors.grey[600]!,
                              ),
                            ),
                            // 控制按钮
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              child: Row(
                                children: [
                                  // 播放/暂停按钮
                                  IconButton(
                                    icon: Icon(
                                      _videoController!.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                    onPressed: () {
                                      if (_videoController!.value.isPlaying) {
                                        _videoController!.pause();
                                      } else {
                                        _videoController!.play();
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  // 时间显示
                                  Text(
                                    '${_formatDuration(_videoController!.value.position)} / ${_formatDuration(_videoController!.value.duration.isNegative ? Duration.zero : _videoController!.value.duration)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  // 全屏按钮
                                  IconButton(
                                    icon: Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                    onPressed: () {
                                      _showFullscreenVideo();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 中央播放按钮（当视频暂停时显示）
                    if (!_videoController!.value.isPlaying)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _videoController!.play();
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 64.sp,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            // 视频加载中或 Vlog 封面显示
            else
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    // 封面图或黑色背景
                    if (coverUrl != null)
                      Container(
                        color: Colors.black,
                        child: Image.network(
                          coverUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      )
                    else
                      Container(color: Colors.grey[800]),
                    // Loading 动画
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 48.w,
                            height: 48.w,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red.shade400,
                              ),
                              strokeWidth: 3,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            '视频加载中...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 格式化视频时长
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  // 全屏播放视频
  void _showFullscreenVideo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullscreenVideoPage(
          videoController: _videoController!,
          videoTitle: _contentResponse?.cur.title ?? '视频',
        ),
        fullscreenDialog: true,
      ),
    );
  }
}

/// 全屏播放视频页面
class _FullscreenVideoPage extends StatefulWidget {
  final VideoPlayerController videoController;
  final String videoTitle;

  const _FullscreenVideoPage({
    required this.videoController,
    required this.videoTitle,
  });

  @override
  State<_FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<_FullscreenVideoPage> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.videoController;
    // 设置横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // 隐藏状态栏和导航栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // 自动隐藏控制栏
    _autoHideControls();
  }

  @override
  void dispose() {
    // 恢复竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 恢复状态栏和导航栏
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  /// 自动隐藏控制栏
  void _autoHideControls() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _showControls) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  /// 点击视频区域切换控制栏显示状态
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _autoHideControls();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                // 控制栏
                if (_showControls)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 标题
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 12,
                            ),
                            child: Text(
                              widget.videoTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // 进度条
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.grey[300]!,
                              backgroundColor: Colors.grey[600]!,
                            ),
                          ),
                          // 控制按钮
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                // 播放/暂停按钮
                                IconButton(
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(width: 8),
                                // 时间显示
                                Text(
                                  '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration.isNegative ? Duration.zero : _controller.value.duration)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                // 退出全屏按钮
                                IconButton(
                                  icon: const Icon(
                                    Icons.fullscreen_exit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // 中央播放按钮（当视频暂停时显示）
                if (!_controller.value.isPlaying && _showControls)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _controller.play();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_circle_fill,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 格式化时长
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}
