import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_application/utils/notification.dart';
import 'package:flutter_application/utils/logger.dart';

@RoutePage()
class PhotoPermissionPage extends StatefulWidget {
  const PhotoPermissionPage({super.key});

  @override
  State<PhotoPermissionPage> createState() => _PhotoPermissionPageState();
}

class _PhotoPermissionPageState extends State<PhotoPermissionPage> {
  String _statusText = '未请求';

  Future<void> _requestPhotoPermission() async {
    // iOS 14+ 推荐用 photo_manager 统一处理
    final PermissionState state = await PhotoManager.requestPermissionExtend();

    switch (state) {
      case PermissionState.authorized:
        setState(() {
          _statusText = '已授权（全部照片）';
        });
        break;

      case PermissionState.limited:
        setState(() {
          _statusText = '已授权（有限照片）';
        });
        break;

      case PermissionState.denied:
        setState(() {
          _statusText = '用户拒绝';
        });
        break;

      case PermissionState.restricted:
        setState(() {
          _statusText = '系统限制（家长控制等）';
        });
        break;
      case PermissionState.notDetermined:
        setState(() {
          _statusText = '未决定';
        });
        break;
    }
  }

  Future<void> _openLimitedPicker() async {
    await PhotoManager.presentLimited();
  }

  Future<void> _openSettings() async {
    await openAppSettings();
  }

  Future<bool> requestNotificationPermission() async {
    final iosPlugin =
        notificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    final bool? granted = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    return granted ?? false;
  }

  // 检查通知权限状态（使用 permission_handler）
  Future<bool> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    logger.info('通知权限状态: $status');
    return status.isGranted;
  }

  Future<void> showNotification() async {
    const DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details =
        NotificationDetails(iOS: iosDetails);

    try {
      // 检查权限状态
      final iosPlugin =
          notificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      
      if (iosPlugin != null) {
        // 再次确认权限
        final bool? hasPermission = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        
        if (hasPermission != true) {
          logger.warning('通知权限未授予');
          return;
        }
      }

      await notificationsPlugin.show(
        0,
        'Flutter 通知测试',
        '这是一条本地通知',
        details,
      );
      
      logger.info('通知发送成功');
    } catch (e) {
      logger.warning('发送通知失败: $e');
    }
  }


  Future<void> _onPressed(BuildContext context) async {
    // 先检查当前权限状态
    final currentStatus = await Permission.notification.status;
    logger.info('当前通知权限状态: $currentStatus');

    // 如果未授权，则请求权限
    if (!currentStatus.isGranted) {
      final granted = await requestNotificationPermission();
      logger.info('权限请求结果: $granted');

      if (!granted) {
        // 等待用户响应权限对话框
        await Future.delayed(const Duration(milliseconds: 300));
        
        // 再次检查权限状态
        final finalStatus = await Permission.notification.status;
        if (!finalStatus.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('通知权限被拒绝，请前往设置开启')),
          );
          return;
        }
      }
    }

    // 确保权限已授予后再发送通知
    final hasPermission = await checkNotificationPermission();
    
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('通知权限未授予，请前往设置开启')),
      );
      return;
    }

    // 发送通知
    await showNotification();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('通知已发送')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('照片权限示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '当前状态：$_statusText',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _requestPhotoPermission,
              child: const Text('请求照片权限'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _openLimitedPicker,
              child: const Text('管理「有限照片」选择'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _openSettings,
              child: const Text('前往系统设置'),
            ),

            SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => _onPressed(context),
              child: const Text('请求通知权限并发送通知'),
            ),
          ],
        ),
      ),
    );
  }
}
