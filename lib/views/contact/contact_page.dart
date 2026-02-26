import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application/widget/iconfont.dart';

@RoutePage()
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final int _maxLength = 200;
  
  // 拖拽相关
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  Offset _dragPosition = Offset.zero;
  Offset _panStartGlobalPosition = Offset.zero; // 拖拽开始时的全局位置
  bool _isDragging = false;
  bool _isInitialized = false;
  final double _fabSize = 56.0; // FloatingActionButton 默认大小

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    // 监听动画值变化
    _positionAnimation.addListener(() {
      if (!_isDragging && _animationController.isAnimating) {
        setState(() {
          _dragPosition = _positionAnimation.value;
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  // 获取右侧目标位置（相对于屏幕）
  // 如果提供了 currentY，则使用该垂直位置，否则使用垂直居中
  Offset _getTargetPosition(Size screenSize, double safeAreaTop, {double? currentY}) {
    final targetY = currentY ?? ((screenSize.height - safeAreaTop) / 2 + safeAreaTop - _fabSize / 2);
    return Offset(
      screenSize.width - 15.w - _fabSize / 2,
      targetY,
    );
  }
  
  // 获取初始位置（右侧15.w，垂直居中50%）
  Offset _getInitialPosition(Size screenSize, double safeAreaTop) {
    return Offset(
      screenSize.width - 15.w - _fabSize / 2,
      (screenSize.height - safeAreaTop) / 2 + safeAreaTop - _fabSize / 2,
    );
  }
  
  // 开始拖拽
  void _onPanStart(DragStartDetails details, Size screenSize, double safeAreaTop, double safeAreaBottom) {
    setState(() {
      _isDragging = true;
      _animationController.stop();
      // 记录拖拽开始时的全局位置和当前图标位置
      _panStartGlobalPosition = details.globalPosition;
    });
  }
  
  // 拖拽中
  void _onPanUpdate(DragUpdateDetails details, Size screenSize, double safeAreaTop, double safeAreaBottom) {
    setState(() {
      // 计算全局位置的偏移量
      final delta = details.globalPosition - _panStartGlobalPosition;
      // 计算新位置（当前图标位置 + 偏移量）
      final newPosition = _dragPosition + delta;
      
      // 限制拖拽范围，不超出屏幕
      final maxX = screenSize.width - _fabSize / 2;
      final minX = _fabSize / 2;
      // 底部边界：考虑安全区域 + 额外的底部边距（比如50.h），确保不被底部导航栏遮挡
      final bottomMargin = 50.h + safeAreaBottom;
      final maxY = screenSize.height - _fabSize / 2 - bottomMargin;
      final minY = safeAreaTop + _fabSize / 2;
      
      _dragPosition = Offset(
        newPosition.dx.clamp(minX, maxX),
        newPosition.dy.clamp(minY, maxY),
      );
      
      // 更新全局位置，用于下次计算
      _panStartGlobalPosition = details.globalPosition;
    });
  }
  
  // 拖拽结束，动画回到右侧（保持当前垂直位置）
  void _onPanEnd(DragEndDetails details, Size screenSize, double safeAreaTop, double safeAreaBottom) {
    setState(() {
      _isDragging = false;
    });
    
    // 确保垂直位置在有效范围内
    final bottomMargin = 50.h + safeAreaBottom;
    final maxY = screenSize.height - _fabSize / 2 - bottomMargin;
    final minY = safeAreaTop + _fabSize / 2;
    final clampedY = _dragPosition.dy.clamp(minY, maxY);
    
    // 目标位置：右侧15.w，但垂直位置保持在拖拽结束时的位置（确保在有效范围内）
    final targetPos = _getTargetPosition(screenSize, safeAreaTop, currentY: clampedY);
    final startPos = _dragPosition;
    
    _positionAnimation = Tween<Offset>(
      begin: startPos,
      end: targetPos,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward(from: 0.0).then((_) {
      if (mounted) {
        setState(() {
          _dragPosition = targetPos;
        });
      }
    });
  }

  // 拨打电话
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('无法拨打电话: $phoneNumber');
    }
  }

  // 打开地图
  Future<void> _openMap(String address) async {
    // 尝试使用 Google Maps
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
    final Uri googleMapsUri = Uri.parse(googleMapsUrl);
    
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      // 如果 Google Maps 不可用，尝试使用系统默认地图
      final String encodedAddress = Uri.encodeComponent(address);
      final Uri mapUri = Uri.parse('geo:0,0?q=$encodedAddress');
      if (await canLaunchUrl(mapUri)) {
        await launchUrl(mapUri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('无法打开地图: $address');
      }
    }
  }

  // 打开浏览器
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('无法打开URL: $url');
    }
  }

  // 提交消息（暂时只 print）
  void _submitMessage() {
    final message = _messageController.text.trim();
    debugPrint('提交的消息: $message');
    // 可以在这里添加清空输入框的逻辑
    // _messageController.clear();
  }

  // 耳机图标点击
  void _onHeadphoneTap() {
    debugPrint('点击了耳机图标');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    
    // 初始化位置（右侧15.w，垂直居中50%）
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _dragPosition = _getInitialPosition(screenSize, safeAreaTop);
            _isInitialized = true;
          });
        }
      });
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        // 点击空白区域时失焦
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                height: 1.sh,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 50.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Contact Me',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        
                        // Message Input Section
                        Container(
                          constraints: BoxConstraints(minHeight: 120.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Stack(
                            children: [
                              TextField(
                                controller: _messageController,
                                maxLength: _maxLength,
                                maxLines: null,
                                minLines: 4,
                                textInputAction: TextInputAction.done, // 将键盘按钮改为"确定"
                                decoration: InputDecoration(
                                  hintText: 'Say something ~',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(12.w),
                                  counterText: '', // 隐藏默认计数器
                                ),
                                onChanged: (value) {
                                  setState(() {}); // 更新字符计数
                                },
                                onSubmitted: (value) {
                                  // 点击键盘上的"确定"按钮时，提交消息并失焦
                                  _submitMessage();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              // 自定义字符计数显示在右下角
                              Positioned(
                                bottom: 8.h,
                                right: 12.w,
                                child: Text(
                                  '${_messageController.text.length}/$_maxLength',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        
                        // Confirm Button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: _submitMessage,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        
                        // Contact Information
                        // Phone
                        GestureDetector(
                          onTap: () => _makePhoneCall('13143352449'),
                          child: Row(
                            children: [
                              Icon(Icons.phone, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                '13143352449',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text('👈', style: TextStyle(fontSize: 12.sp)),
                              SizedBox(width: 4.w),
                              Text(
                                'click to call me',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        
                        // Email
                        Row(
                          children: [
                            Text('@', style: TextStyle(fontSize: 18.sp)),
                            SizedBox(width: 8.w),
                            Text(
                              'rollercompanion@163.com',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        
                        // Address
                        GestureDetector(
                          onTap: () => _openMap('GuangZhou'),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'GuangZhou',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text('👈', style: TextStyle(fontSize: 12.sp)),
                              SizedBox(width: 4.w),
                              Text(
                                'click to see',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        
                        // Social Media Section
                        Text(
                          'Follow me on social media',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Divider(color: Colors.black, thickness: 1),
                        SizedBox(height: 15.h),
                        
                        // Social Media Icons
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _openUrl('https://github.com/KKslide'),
                              child: Icon(
                                IconFont.github,
                                size: 24.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () => _openUrl('https://www.facebook.com'),
                              child: Icon(
                                IconFont.facebook,
                                size: 24.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () => _openUrl('https://x.com/KK_slide'),
                              child: Icon(
                                IconFont.twitter,
                                size: 24.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () => _openUrl('https://www.instagram.com/kangyouknowwho/'),
                              child: Icon(
                                IconFont.instagram,
                                size: 24.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () => _openUrl('https://weibo.com/u/1915491875'),
                              child: Icon(
                                IconFont.weibo,
                                size: 24.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        
                        // Comments Message
                        Center(
                          child: Text(
                            'there is no more comments',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
            // 可拖拽的耳机图标
            if (_isInitialized)
            Positioned(
              left: _dragPosition.dx - _fabSize / 2,
              top: _dragPosition.dy - _fabSize / 2,
              child: GestureDetector(
                // 移除 onTap，避免与拖拽冲突
                // 使用 onPanEnd 来检测点击（如果移动距离很小）
                onPanStart: (details) => _onPanStart(details, screenSize, safeAreaTop, safeAreaBottom),
                onPanUpdate: (details) => _onPanUpdate(details, screenSize, safeAreaTop, safeAreaBottom),
                onPanEnd: (details) {
                  _onPanEnd(details, screenSize, safeAreaTop, safeAreaBottom);
                  // 检测是否为点击（移动距离很小）
                  if (details.velocity.pixelsPerSecond.distance < 10) {
                    _onHeadphoneTap();
                  }
                },
                child: Container(
                  width: _fabSize,
                  height: _fabSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.headphones,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
