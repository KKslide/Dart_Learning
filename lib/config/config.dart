import 'dart:io';
import 'package:flutter_application/utils/logger.dart';

class Config {
  static bool? debug = true;
  static const int _defaultPort = 8088;
  static String _baseUrl = 'http://127.0.0.1:$_defaultPort';

  /// 现在暂时用本地ip开发, 如果后面要发布到ipa或者apk的话, 再改成线上ip或者域名
  static Future<void> init({int port = _defaultPort}) async {
    final localIp = await _findLocalIpv4();
    final host = localIp ?? '127.0.0.1';
    _baseUrl = 'http://$host:$port';

    logger.info('================ 查看配置信息 =================');
    logger.info('baseUrl: $_baseUrl');
    logger.info('debug: $debug');
    logger.info('port: $port');
    logger.info('localIp: $localIp');
    logger.info('host: $host');
  }

  static String get baseUrl => _baseUrl;

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
          if (ip.startsWith('127.')) {
            continue;
          }
          fallback ??= ip;
          if (_isPrivateIpv4(ip)) {
            return ip;
          }
        }
      }
      return fallback;
    } catch (_) {
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
    if (parts.length != 4) {
      return false;
    }
    final secondOctet = int.tryParse(parts[1]);
    return secondOctet != null && secondOctet >= 16 && secondOctet <= 31;
  }
}
