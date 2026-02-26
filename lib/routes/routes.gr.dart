// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i28;
import 'package:flutter/material.dart' as _i29;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/01_counter_page.dart'
    as _i9;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/02_theme_setting_page.dart'
    as _i22;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/03_profile_page.dart'
    as _i16;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/04_api_req_page.dart'
    as _i3;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/05_search_demo_page.dart'
    as _i19;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/06_todo_demo_page.dart'
    as _i23;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/07_global_notifier_page.dart'
    as _i10;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/joke_page.dart'
    as _i14;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/riverpod_basic_page.dart'
    as _i18;
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/todo_demo/todo_page.dart'
    as _i24;
import 'package:flutter_application/_flutter_plugins/_shared_preferences_/basic_operation.dart'
    as _i20;
import 'package:flutter_application/_flutter_widgets_note_/_animation_/01_animation_demo_page.dart'
    as _i2;
import 'package:flutter_application/views/about/about_page.dart' as _i1;
import 'package:flutter_application/views/about/resume_preview_page.dart'
    as _i17;
import 'package:flutter_application/views/blog/blog_list_page.dart' as _i4;
import 'package:flutter_application/views/blog/blog_page.dart' as _i5;
import 'package:flutter_application/views/blog/trial_demos.dart' as _i25;
import 'package:flutter_application/views/contact/contact_page.dart' as _i7;
import 'package:flutter_application/views/content/content_page.dart' as _i8;
import 'package:flutter_application/views/home/home_page.dart' as _i11;
import 'package:flutter_application/views/index_page.dart' as _i12;
import 'package:flutter_application/views/initial/initial_page.dart' as _i13;
import 'package:flutter_application/views/trials/camera_demo_page.dart' as _i6;
import 'package:flutter_application/views/trials/photo_permission_page.dart'
    as _i15;
import 'package:flutter_application/views/trials/sticky_header.dart' as _i21;
import 'package:flutter_application/views/trials/typing_effect_page.dart'
    as _i26;
import 'package:flutter_application/widget/webview_page.dart' as _i27;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i28.PageRouteInfo<void> {
  const AboutRoute({List<_i28.PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.AnimationDemoPage]
class AnimationDemoRoute extends _i28.PageRouteInfo<void> {
  const AnimationDemoRoute({List<_i28.PageRouteInfo>? children})
    : super(AnimationDemoRoute.name, initialChildren: children);

  static const String name = 'AnimationDemoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i2.AnimationDemoPage();
    },
  );
}

/// generated route for
/// [_i3.ApiReqPage]
class ApiReqRoute extends _i28.PageRouteInfo<void> {
  const ApiReqRoute({List<_i28.PageRouteInfo>? children})
    : super(ApiReqRoute.name, initialChildren: children);

  static const String name = 'ApiReqRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i3.ApiReqPage();
    },
  );
}

/// generated route for
/// [_i4.BlogListTrialPage]
class BlogListTrialRoute extends _i28.PageRouteInfo<void> {
  const BlogListTrialRoute({List<_i28.PageRouteInfo>? children})
    : super(BlogListTrialRoute.name, initialChildren: children);

  static const String name = 'BlogListTrialRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i4.BlogListTrialPage();
    },
  );
}

/// generated route for
/// [_i5.BlogPage]
class BlogRoute extends _i28.PageRouteInfo<void> {
  const BlogRoute({List<_i28.PageRouteInfo>? children})
    : super(BlogRoute.name, initialChildren: children);

  static const String name = 'BlogRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i5.BlogPage();
    },
  );
}

/// generated route for
/// [_i6.CameraDemoPage]
class CameraDemoRoute extends _i28.PageRouteInfo<void> {
  const CameraDemoRoute({List<_i28.PageRouteInfo>? children})
    : super(CameraDemoRoute.name, initialChildren: children);

  static const String name = 'CameraDemoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i6.CameraDemoPage();
    },
  );
}

/// generated route for
/// [_i7.ContactPage]
class ContactRoute extends _i28.PageRouteInfo<void> {
  const ContactRoute({List<_i28.PageRouteInfo>? children})
    : super(ContactRoute.name, initialChildren: children);

  static const String name = 'ContactRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i7.ContactPage();
    },
  );
}

/// generated route for
/// [_i8.ContentPage]
class ContentRoute extends _i28.PageRouteInfo<ContentRouteArgs> {
  ContentRoute({
    _i29.Key? key,
    required int contentId,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         ContentRoute.name,
         args: ContentRouteArgs(key: key, contentId: contentId),
         initialChildren: children,
       );

  static const String name = 'ContentRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContentRouteArgs>();
      return _i8.ContentPage(key: args.key, contentId: args.contentId);
    },
  );
}

class ContentRouteArgs {
  const ContentRouteArgs({this.key, required this.contentId});

  final _i29.Key? key;

  final int contentId;

  @override
  String toString() {
    return 'ContentRouteArgs{key: $key, contentId: $contentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ContentRouteArgs) return false;
    return key == other.key && contentId == other.contentId;
  }

  @override
  int get hashCode => key.hashCode ^ contentId.hashCode;
}

/// generated route for
/// [_i9.CounterPage]
class CounterRoute extends _i28.PageRouteInfo<void> {
  const CounterRoute({List<_i28.PageRouteInfo>? children})
    : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i9.CounterPage();
    },
  );
}

/// generated route for
/// [_i10.GlobalNotifierPage]
class GlobalNotifierRoute extends _i28.PageRouteInfo<void> {
  const GlobalNotifierRoute({List<_i28.PageRouteInfo>? children})
    : super(GlobalNotifierRoute.name, initialChildren: children);

  static const String name = 'GlobalNotifierRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i10.GlobalNotifierPage();
    },
  );
}

/// generated route for
/// [_i11.HomePage]
class HomeRoute extends _i28.PageRouteInfo<void> {
  const HomeRoute({List<_i28.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i11.HomePage();
    },
  );
}

/// generated route for
/// [_i12.IndexPage]
class IndexRoute extends _i28.PageRouteInfo<void> {
  const IndexRoute({List<_i28.PageRouteInfo>? children})
    : super(IndexRoute.name, initialChildren: children);

  static const String name = 'IndexRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i12.IndexPage();
    },
  );
}

/// generated route for
/// [_i13.InitialPage]
class InitialRoute extends _i28.PageRouteInfo<void> {
  const InitialRoute({List<_i28.PageRouteInfo>? children})
    : super(InitialRoute.name, initialChildren: children);

  static const String name = 'InitialRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i13.InitialPage();
    },
  );
}

/// generated route for
/// [_i14.JokePage]
class JokeRoute extends _i28.PageRouteInfo<void> {
  const JokeRoute({List<_i28.PageRouteInfo>? children})
    : super(JokeRoute.name, initialChildren: children);

  static const String name = 'JokeRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i14.JokePage();
    },
  );
}

/// generated route for
/// [_i15.PhotoPermissionPage]
class PhotoPermissionRoute extends _i28.PageRouteInfo<void> {
  const PhotoPermissionRoute({List<_i28.PageRouteInfo>? children})
    : super(PhotoPermissionRoute.name, initialChildren: children);

  static const String name = 'PhotoPermissionRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i15.PhotoPermissionPage();
    },
  );
}

/// generated route for
/// [_i16.ProfilePage]
class ProfileRoute extends _i28.PageRouteInfo<void> {
  const ProfileRoute({List<_i28.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i16.ProfilePage();
    },
  );
}

/// generated route for
/// [_i17.ResumePreviewPage]
class ResumePreviewRoute extends _i28.PageRouteInfo<ResumePreviewRouteArgs> {
  ResumePreviewRoute({
    _i29.Key? key,
    required String pdfUrl,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         ResumePreviewRoute.name,
         args: ResumePreviewRouteArgs(key: key, pdfUrl: pdfUrl),
         initialChildren: children,
       );

  static const String name = 'ResumePreviewRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResumePreviewRouteArgs>();
      return _i17.ResumePreviewPage(key: args.key, pdfUrl: args.pdfUrl);
    },
  );
}

class ResumePreviewRouteArgs {
  const ResumePreviewRouteArgs({this.key, required this.pdfUrl});

  final _i29.Key? key;

  final String pdfUrl;

  @override
  String toString() {
    return 'ResumePreviewRouteArgs{key: $key, pdfUrl: $pdfUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResumePreviewRouteArgs) return false;
    return key == other.key && pdfUrl == other.pdfUrl;
  }

  @override
  int get hashCode => key.hashCode ^ pdfUrl.hashCode;
}

/// generated route for
/// [_i18.RiverpodBasicPage]
class RiverpodBasicRoute extends _i28.PageRouteInfo<void> {
  const RiverpodBasicRoute({List<_i28.PageRouteInfo>? children})
    : super(RiverpodBasicRoute.name, initialChildren: children);

  static const String name = 'RiverpodBasicRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i18.RiverpodBasicPage();
    },
  );
}

/// generated route for
/// [_i19.SearchDemoPage]
class SearchDemoRoute extends _i28.PageRouteInfo<void> {
  const SearchDemoRoute({List<_i28.PageRouteInfo>? children})
    : super(SearchDemoRoute.name, initialChildren: children);

  static const String name = 'SearchDemoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i19.SearchDemoPage();
    },
  );
}

/// generated route for
/// [_i20.SharedPreferencesPage]
class SharedPreferencesRoute extends _i28.PageRouteInfo<void> {
  const SharedPreferencesRoute({List<_i28.PageRouteInfo>? children})
    : super(SharedPreferencesRoute.name, initialChildren: children);

  static const String name = 'SharedPreferencesRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i20.SharedPreferencesPage();
    },
  );
}

/// generated route for
/// [_i21.StickyHeaderPage]
class StickyHeaderRoute extends _i28.PageRouteInfo<void> {
  const StickyHeaderRoute({List<_i28.PageRouteInfo>? children})
    : super(StickyHeaderRoute.name, initialChildren: children);

  static const String name = 'StickyHeaderRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i21.StickyHeaderPage();
    },
  );
}

/// generated route for
/// [_i22.ThemeSettingPage]
class ThemeSettingRoute extends _i28.PageRouteInfo<void> {
  const ThemeSettingRoute({List<_i28.PageRouteInfo>? children})
    : super(ThemeSettingRoute.name, initialChildren: children);

  static const String name = 'ThemeSettingRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i22.ThemeSettingPage();
    },
  );
}

/// generated route for
/// [_i23.TodoDemoPage]
class TodoDemoRoute extends _i28.PageRouteInfo<void> {
  const TodoDemoRoute({List<_i28.PageRouteInfo>? children})
    : super(TodoDemoRoute.name, initialChildren: children);

  static const String name = 'TodoDemoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i23.TodoDemoPage();
    },
  );
}

/// generated route for
/// [_i24.TodoPage]
class TodoRoute extends _i28.PageRouteInfo<void> {
  const TodoRoute({List<_i28.PageRouteInfo>? children})
    : super(TodoRoute.name, initialChildren: children);

  static const String name = 'TodoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i24.TodoPage();
    },
  );
}

/// generated route for
/// [_i25.TrialDemos]
class TrialDemos extends _i28.PageRouteInfo<void> {
  const TrialDemos({List<_i28.PageRouteInfo>? children})
    : super(TrialDemos.name, initialChildren: children);

  static const String name = 'TrialDemos';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i25.TrialDemos();
    },
  );
}

/// generated route for
/// [_i26.TypingEffectPage]
class TypingEffectRoute extends _i28.PageRouteInfo<void> {
  const TypingEffectRoute({List<_i28.PageRouteInfo>? children})
    : super(TypingEffectRoute.name, initialChildren: children);

  static const String name = 'TypingEffectRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i26.TypingEffectPage();
    },
  );
}

/// generated route for
/// [_i27.WhateverDetailPage]
class WhateverDetailRoute extends _i28.PageRouteInfo<WhateverDetailRouteArgs> {
  WhateverDetailRoute({
    _i29.Key? key,
    required String url,
    required String title,
    String? html,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         WhateverDetailRoute.name,
         args: WhateverDetailRouteArgs(
           key: key,
           url: url,
           title: title,
           html: html,
         ),
         initialChildren: children,
       );

  static const String name = 'WhateverDetailRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WhateverDetailRouteArgs>();
      return _i27.WhateverDetailPage(
        key: args.key,
        url: args.url,
        title: args.title,
        html: args.html,
      );
    },
  );
}

class WhateverDetailRouteArgs {
  const WhateverDetailRouteArgs({
    this.key,
    required this.url,
    required this.title,
    this.html,
  });

  final _i29.Key? key;

  final String url;

  final String title;

  final String? html;

  @override
  String toString() {
    return 'WhateverDetailRouteArgs{key: $key, url: $url, title: $title, html: $html}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WhateverDetailRouteArgs) return false;
    return key == other.key &&
        url == other.url &&
        title == other.title &&
        html == other.html;
  }

  @override
  int get hashCode =>
      key.hashCode ^ url.hashCode ^ title.hashCode ^ html.hashCode;
}
