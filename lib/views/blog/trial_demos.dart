import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application/routes/routes.gr.dart';

@RoutePage()
class TrialDemos extends StatefulWidget {
  const TrialDemos({super.key});

  @override
  State<TrialDemos> createState() => _TrialDemosState();
}

class _TrialDemosState extends State<TrialDemos> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // keepAlive关键点1

  @override
  Widget build(BuildContext context) {
    super.build(context); // keepAlive关键点2
    final router = context.router;
    return Scaffold(
      appBar: AppBar(title: const Text('some demos')),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                router.push(CounterRoute());
              },
              child: Text('Counter', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(ThemeSettingRoute());
              },
              child: Text('Theme', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(ProfileRoute());
              },
              child: Text('Login', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(ApiReqRoute());
              },
              child: Text('Api Request', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(SearchDemoRoute());
              },
              child: Text('Debounce Search Demo', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(TodoDemoRoute());
              },
              child: Text('The Todo Demo', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(WhateverDetailRoute(
                  title: '富文本页面TEST',
                  url: 'https://www.baidu.com',
                ));
              },
              child: Text('富文本页面', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(StickyHeaderRoute());
              },
              child: Text('Scroll and Stick', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(SharedPreferencesRoute());
              },
              child: Text('本地存储', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(PhotoPermissionRoute());
              },
              child: Text('相册权限', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(CameraDemoRoute());
              },
              child: Text('Camera Demo', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(BlogListTrialRoute());
              },
              child: Text('Dio Trial', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(GlobalNotifierRoute());
              },
              child: Text('Global Notification', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                router.push(AnimationDemoRoute());
              },
              child: Text('Animation Demo', style: TextStyle(fontSize: 16.sp)),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
  
}
