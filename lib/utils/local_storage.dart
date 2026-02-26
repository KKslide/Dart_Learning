import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// 包含值和过期时间的数据类
class ExpirableValue {
  final String value;
  final int expireAt;

  ExpirableValue({required this.value, required this.expireAt});

  Map<String, dynamic> toJson() => {'value': value, 'expireAt': expireAt};

  factory ExpirableValue.fromJson(Map<String, dynamic> json) =>
      ExpirableValue(value: json['value'], expireAt: json['expireAt']);
}

/// 本地的存储
class LocalStorage {
  static Future<Future<bool>> save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?>? get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<Future<bool>> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<Future<bool>> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  /// 存储带过期时间的数据
  static Future<Future<Future<bool>>> saveWithExpire(String key, String value, Duration duration) async {
    final expireAt = DateTime.now().add(duration).millisecondsSinceEpoch;
    final data = ExpirableValue(value: value, expireAt: expireAt);
    return save(key, jsonEncode(data.toJson()));
  }

  /// 获取数据，如果过期则删除并返回null
  static Future<String?>? getWithExpire(String key) async {
    final jsonString = await get(key);
    if (jsonString == null) {
      return null;
    }

    try {
      final jsonMap = jsonDecode(jsonString);
      final data = ExpirableValue.fromJson(jsonMap);

      // 检查是否过期
      if (DateTime.now().millisecondsSinceEpoch > data.expireAt) {
        // 过期则删除并返回null
        await remove(key);
        return null;
      }

      return data.value;
    } catch (e) {
      // 解析失败也删除该条数据
      await remove(key);
      return null;
    }
  }
}