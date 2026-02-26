import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    // 基础布局:
    AutoRoute(page: IndexRoute.page, path: '/'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: BlogRoute.page, path: '/blog'),
    AutoRoute(page: ContentRoute.page, path: '/content/:contentId'),
    AutoRoute(page: AboutRoute.page, path: '/about'),
    AutoRoute(page: ResumePreviewRoute.page, path: '/resume_preview'),
    AutoRoute(page: ContactRoute.page, path: '/contact'),
    // 以下是 riverpod 的学习记录:
    AutoRoute(page: CounterRoute.page, path: '/counter'),
    AutoRoute(page: ThemeSettingRoute.page, path: '/theme_setting'),
    AutoRoute(page: ProfileRoute.page, path: '/profile_page'),
    AutoRoute(page: ApiReqRoute.page, path: '/api_req'),
    AutoRoute(page: SearchDemoRoute.page, path: '/search_demo'),
    AutoRoute(page: TodoDemoRoute.page, path: '/search_demo'),
    AutoRoute(page: GlobalNotifierRoute.page, path: '/global_notifier_demo'),
    // 以下是一些尝试页面:
    AutoRoute(page: WhateverDetailRoute.page, path: '/whatever_detail'),
    AutoRoute(page: StickyHeaderRoute.page, path: '/sticky_header'),
    AutoRoute(page: PhotoPermissionRoute.page, path: '/photo_permission'),
    AutoRoute(page: CameraDemoRoute.page, path: '/camera_demo'),
    AutoRoute(page: BlogListTrialRoute.page, path: '/dio_trial'),
    // 插件学习:
    AutoRoute(page: SharedPreferencesRoute.page, path: '/shared_preferences'),
    // 动画学习:
    AutoRoute(page: AnimationDemoRoute.page, path: '/animation_demo')
  ];
}