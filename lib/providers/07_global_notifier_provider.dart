// import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '07_global_notifier_provider.g.dart';

enum NotifierType {
  success,
  error,
  warning,
  info
}

class AppNotification {
  final String message;
  final NotifierType type;
  final DateTime timestamp;

  AppNotification({
    required this.message,
    required this.type
  }): timestamp = DateTime.now();
  
}

@riverpod
class NotificationQueue extends _$NotificationQueue {
  @override
  List<AppNotification> build() {
    return [];
  }

  void showSuccess(String message) {
    _addNotification(AppNotification(
      message: message,
      type: NotifierType.success
    ));
  }

  void showError(String message) {
    _addNotification(AppNotification(
      message: message,
      type: NotifierType.error,
    ));
  }
  
  void showWarning(String message) {
    _addNotification(AppNotification(
      message: message,
      type: NotifierType.warning,
    ));
  }
  
  void showInfo(String message) {
    _addNotification(AppNotification(
      message: message,
      type: NotifierType.info,
    ));
  }

  void _addNotification(AppNotification notification) {
    state = [...state, notification];

    Future.delayed(Duration(seconds: 3), () {
      state = state.where((n) => n != notification).toList();
    });
  }

  void dismiss(AppNotification notification) {
    state = state.where((n) => n != notification).toList();
  }
  
}