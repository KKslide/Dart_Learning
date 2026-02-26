import 'package:flutter_application/utils/http_manager/code.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// 错误拦截
class ErrorInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    //没有网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          response: Response(
            requestOptions: options,
            data: {"code": Code.networkError, "msg": "网络异常"},
          ),
        ),
      );
    }
    return super.onRequest(options, handler);
  }
}
