import 'package:flutter_application/utils/local_storage.dart';
import 'package:dio/dio.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {

    var token = await getAuthorization();

    if(token != null) {
      options.headers["X-User-Token"] = token;
    } else {
      options.headers["X-User-Token"] = "un-auth";
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    return super.onResponse(response, handler);
  }

  ///清除授权
  void clearAuthorization() {
    LocalStorage.remove('token');
  }

  ///获取授权token
  Future<dynamic> getAuthorization() async {
    var token = await LocalStorage.get('token');
    return token;
  }
}
