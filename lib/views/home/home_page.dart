import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const _imagePaths = [
    'assets/images/pic_1.jpg',
    'assets/images/pic_2.jpg',
    'assets/images/pic_3.jpg',
    'assets/images/pic_4.jpg',
    'assets/images/pic_5.jpg',
  ];

  int _currentImageIndex = 0;
  Timer? _timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<TypewriterAnimatedText> _generateTexts(List<String> textList) {
    List<TypewriterAnimatedText> rawList = textList.map((String val) {

      return TypewriterAnimatedText(
        val,
        textStyle: TextStyle( color: Colors.white, fontSize: 30.sp ),
        speed: Duration(milliseconds: 100),
        curve: Curves.bounceInOut,
        cursor: '|',
      );
    }).toList();

    return rawList;
  }
  
  @override
  Widget build(BuildContext context) {
    final router = context.router;
    super.build(context); // 必须调用，确保保持状态生效
    // 下面四种方式都可以进行跳转
    // router.navigatePath('/blog');
    // router.push(const BlogRoute());
    // context.router.pushNamed('/blog');
    // context.pushRoute(const BlogRoute());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: SizedBox.expand(
                key: ValueKey<int>(_currentImageIndex),
                child: Image.asset(
                  _imagePaths[_currentImageIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150.h,
            left: 15.w,
            right: 15.w,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: _generateTexts([
                'I`m Lykang',
                'A Front End Engineer',
                'Work and live in GuangZhou',
                'Nice to meet you!😁'
              ]),
            )
          ),
          
        ],
      )
    );
  }
  
}
