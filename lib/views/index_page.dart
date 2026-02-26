import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/widget/iconfont.dart';
// 页面引入
import 'package:flutter_application/views/home/home_page.dart';
import 'package:flutter_application/views/blog/blog_page.dart';
import 'package:flutter_application/views/about/about_page.dart';
import 'package:flutter_application/views/contact/contact_page.dart';

class TabBarItem {
  final String title;
  final IconData icon;

  TabBarItem({required this.title, required this.icon});
}

@RoutePage()
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late PageController _pageController;
  
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const BlogPage(),
    const AboutPage(),
    const ContactPage(),
  ];

  List<TabBarItem> tabBars = [
    TabBarItem(title: 'Home', icon: IconFont.home),
    TabBarItem(title: 'Blog', icon: IconFont.blog),
    TabBarItem(title: 'About', icon: IconFont.about),
    TabBarItem(title: 'Contact', icon: IconFont.contact)
  ];

  List<Widget> _renderTabBarItems() {
    return List.generate(tabBars.length, (index) {
      final isHome = _currentIndex == 0;
      final isCurrentTab = _currentIndex == index;
      final iconColor = isHome
          ? (isCurrentTab ? Colors.white : Colors.white70)
          : (isCurrentTab ? Colors.black87 : Colors.grey);
      final textColor = isHome
          ? (isCurrentTab ? Colors.white : Colors.white70)
          : (isCurrentTab ? Colors.black87 : Colors.grey);
      
      return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            _pageController.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          child: Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: iconColor),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  builder: (context, color, child) {
                    return Icon(
                      size: 24.sp,
                      tabBars[index].icon,
                      color: color,
                    );
                  },
                ),
                SizedBox(height: 2.w),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                  ),
                  child: Text(
                    tabBars[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _renderTabBar() {
    bool isHome = _currentIndex == 0;
    int seconds = isHome ? 300 : 0;
    List<Color> linearColors = isHome
      ? [Colors.black12, Colors.transparent]
      : [Colors.white, Colors.white];
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: seconds),
        curve: Curves.easeInOut,
        width: 1.sw,
        height: 80.h,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 6.h),
        decoration: BoxDecoration(
          // color: _currentIndex == 0 ? Colors.transparent : Colors.white,
          gradient: LinearGradient(
              colors: linearColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          boxShadow: _currentIndex == 0
              ? []
              : [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.w,
                    spreadRadius: 5.w,
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _renderTabBarItems()
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }
  
  @override
  Widget build(BuildContext context) {
    final router = context.router;
    
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _pages,
          ),
          // todo 考虑这里是否要做一个悬浮设置按钮
          // Positioned(
          //   bottom: 100.h,
          //   right: 20.w,
          //   child: Container(
          //     width: 50.w,
          //     height: 50.w,
          //     color: Colors.red,
          //   ),
          // ),
          _renderTabBar(),
        ],
      )
    );
  }
}