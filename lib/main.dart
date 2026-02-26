import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/app.dart';
import 'utils/logger.dart';
import 'package:flutter_application/utils/notification.dart';

void main() async {
  // 测试全局logger
  logger.info("应用启动...");
  
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 强制竖屏
    // DeviceOrientation.portraitDown, // 强制横屏
  ]);
  await initNotifications(); // 获取通知权限
  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(
        observers: [
          RiverpodLogObserver()
        ],
      ), // todo 后面再抽离出去
      child: App(),
    ),
  );
}
