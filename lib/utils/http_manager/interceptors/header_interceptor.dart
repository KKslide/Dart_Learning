import 'package:flutter_application/config/config.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = Config.baseUrl;
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);
    super.onRequest(options, handler);
  }
}