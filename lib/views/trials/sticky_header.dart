import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class StickyHeaderPage extends StatefulWidget {
  const StickyHeaderPage({super.key});

  @override
  State<StickyHeaderPage> createState() => _StickyHeaderPageState();
}

class _StickyHeaderPageState extends State<StickyHeaderPage> {
  final ScrollController _scrollController = ScrollController();
  
  late double statusBarHeight;
  late double appBarHeight;
  late double totalTopHeight;

  // AppBar 背景透明度 (0.0 完全透明, 1.0 完全不透明)
  double _appBarOpacity = 0.0;
  
  // Tabs 是否吸顶
  bool _isTabsSticky = false;
  
  // 背景图高度
  final double _headerHeight = 200.0;
  
  // Tabs 的高度
  final double _tabsHeight = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 获取滚动偏移量
    final offset = _scrollController.offset;
    
    // 计算 AppBar 背景透明度
    // 滚动距离在 0 到 headerHeight 之间时,逐渐从透明变为不透明
    final opacity = (offset / _headerHeight).clamp(0.0, 1.0);
    
    // 判断 Tabs 是否应该吸顶
    // 当滚动超过背景图高度时,Tabs 吸顶
    final isSticky = offset >= _headerHeight - totalTopHeight;
    
    setState(() {
      _appBarOpacity = opacity;
      _isTabsSticky = isSticky;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取状态栏高度
    statusBarHeight = MediaQuery.of(context).padding.top;
    appBarHeight = 56.0;
    totalTopHeight = statusBarHeight + appBarHeight;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      // 自定义 AppBar,背景色根据滚动动态变化
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _appBarOpacity),
            boxShadow: _appBarOpacity > 0.5
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'sticky header',
              style: TextStyle(
                color: _appBarOpacity > 0.5 ? Colors.black : Colors.white,
              ),
            ),
            iconTheme: IconThemeData(
              color: _appBarOpacity > 0.5 ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 主内容区域
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 背景图区域
              SliverToBoxAdapter(
                child: Container(
                  height: _headerHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/400/200',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    // 添加渐变遮罩,让文字更清晰
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Tabs 区域 (会被顶部的固定 Tabs 覆盖)
              SliverToBoxAdapter(
                child: Opacity(
                  opacity: _isTabsSticky ? 0.0 : 1.0,
                  child: _buildTabs(),
                ),
              ),
              
              // 内容列表
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'List ${index + 1}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                  childCount: 30,
                ),
              ),
            ],
          ),
          
          // 吸顶的 Tabs (当滚动到一定位置时显示)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            // 吸顶时: 状态栏高度 + AppBar 高度
            // 未吸顶时: 隐藏在顶部外面
            top: _isTabsSticky ? totalTopHeight : -_tabsHeight,
            left: 0,
            right: 0,
            child: _buildTabs(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: _tabsHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab('1', true),
          ),
          Expanded(
            child: _buildTab('2', false),
          ),
          Expanded(
            child: _buildTab('3', false),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
