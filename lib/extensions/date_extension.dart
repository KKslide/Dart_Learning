import 'package:intl/intl.dart';

extension DateTimeExtension on String {
  /// 格式化日期字符串
  /// 
  /// 示例:
  /// ```dart
  /// '2024-01-20T14:43:32.000Z'.formatDate('yyyy-MM-dd HH:mm:ss')
  /// ```
  String formatDate(String format) {
    try {
      final DateTime dateTime = DateTime.parse(this);
      final DateTime local = dateTime.toLocal();
      final DateFormat formatter = DateFormat(format);
      return formatter.format(local);
    } catch (e) {
      return this;
    }
  }
  
  /// 转换为 DateTime 对象
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this).toLocal();
    } catch (e) {
      return null;
    }
  }
  
  /// 相对时间 (类似 dayjs().fromNow())
  /// 
  /// 示例:
  /// ```dart
  /// '2024-01-20T14:43:32.000Z'.timeAgo()
  /// // 输出: 3小时前 / 2天前 / 1个月前
  /// ```
  String timeAgo() {
    try {
      final DateTime dateTime = DateTime.parse(this).toLocal();
      final DateTime now = DateTime.now();
      final Duration diff = now.difference(dateTime);
      
      if (diff.inSeconds < 60) {
        return '刚刚';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}分钟前';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}小时前';
      } else if (diff.inDays < 30) {
        return '${diff.inDays}天前';
      } else if (diff.inDays < 365) {
        return '${(diff.inDays / 30).floor()}个月前';
      } else {
        return '${(diff.inDays / 365).floor()}年前';
      }
    } catch (e) {
      return this;
    }
  }
}