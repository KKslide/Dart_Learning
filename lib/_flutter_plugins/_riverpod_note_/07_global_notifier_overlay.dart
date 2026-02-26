import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/07_global_notifier_provider.dart';

class NotificationOverlay extends ConsumerWidget {
  final Widget child;
  
  const NotificationOverlay({super.key, required this.child});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationQueueProvider);
    
    return Stack(
      children: [
        child,
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Column(
            children: notifications.map((notification) {
              Color color;
              IconData icon;
              
              switch (notification.type) {
                case NotifierType.success:
                  color = Colors.green;
                  icon = Icons.check_circle;
                  break;
                case NotifierType.error:
                  color = Colors.red;
                  icon = Icons.error;
                  break;
                case NotifierType.warning:
                  color = Colors.orange;
                  icon = Icons.warning;
                  break;
                case NotifierType.info:
                  color = Colors.blue;
                  icon = Icons.info;
                  break;
              }
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            notification.message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => ref.read(notificationQueueProvider.notifier)
                              .dismiss(notification),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}