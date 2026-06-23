import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application/utils/logger.dart';

/// 客户端 IP 获取工具
class IpUtil {
  /// 获取客户端 IP 地址
  ///
  /// 优先尝试从外部服务获取公网 IP（超时 3 秒），
  /// 失败则回退到局域网 IP，再失败返回 "127.0.0.1"
  static Future<String> getClientIp() async {
    // 1. 尝试公网 IP
    final publicIp = await _fetchPublicIp();
    if (publicIp != null) return publicIp;

    // 2. 回退：局域网 IP
    final localIp = await _findLocalIpv4();
    if (localIp != null) return localIp;

    // 3. 兜底
    return '127.0.0.1';
  }

  /// 通过 ipify 获取公网 IP，超时 3 秒
  static Future<String?> _fetchPublicIp() async {
    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
      ));
      final response = await dio.get('https://api.ipify.org?format=json');
      return response.data['ip'] as String?;
    } catch (e) {
      logger.info('获取公网 IP 失败: $e');
      return null;
    }
  }

  /// 通过 dart:io 获取局域网 IPv4 地址
  static Future<String?> _findLocalIpv4() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );

      String? fallback;
      for (final interface in interfaces) {
        for (final address in interface.addresses) {
          final ip = address.address;
          if (ip.startsWith('127.')) continue;
          fallback ??= ip;
          if (_isPrivateIpv4(ip)) return ip;
        }
      }
      return fallback;
    } catch (e) {
      logger.info('获取本地 IP 失败: $e');
      return null;
    }
  }

  static bool _isPrivateIpv4(String ip) {
    return ip.startsWith('10.') ||
        ip.startsWith('192.168.') ||
        (ip.startsWith('172.') && _isIn172PrivateRange(ip));
  }

  static bool _isIn172PrivateRange(String ip) {
    final parts = ip.split('.');
    if (parts.length != 4) return false;
    final secondOctet = int.tryParse(parts[1]);
    return secondOctet != null && secondOctet >= 16 && secondOctet <= 31;
  }
}
