import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/07_global_notifier_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_application/_flutter_plugins/_riverpod_note_/07_global_notifier_overlay.dart';

@RoutePage()
class GlobalNotifierPage extends ConsumerWidget {
  const GlobalNotifierPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('System Notification'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  ref.read(notificationQueueProvider.notifier)
                      .showSuccess('操作成功!');
                },
                child: Text('显示成功消息'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  ref.read(notificationQueueProvider.notifier)
                      .showError('操作失败!');
                },
                child: Text('显示错误消息'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  ref.read(notificationQueueProvider.notifier)
                      .showWarning('警告信息!');
                },
                child: Text('显示警告消息'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  ref.read(notificationQueueProvider.notifier)
                      .showInfo('提示信息!');
                },
                child: Text('显示提示消息'),
              ),
            ],
          ),
        ),
      )
    );
  }
}