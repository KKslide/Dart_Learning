import 'package:flutter_application/utils/http_manager/error_builder.dart';
import 'package:flutter_application/utils/http_manager/interceptors/error_interceptor.dart';
import 'package:flutter_application/utils/http_manager/interceptors/header_interceptor.dart';
// import 'package:flutter_application/utils/http_manager/interceptors/token_interceptor.dart';
import 'package:flutter_application/utils/http_manager/result_data.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application/common/talker/talker_logger.dart';
import 'dart:collection';
import 'package:flutter_application/utils/http_manager/code.dart';
import 'package:flutter_application/config/config.dart';

// http封装请求
class HttpManager {
  static const contentTypeJson = "application/json";
  static const contentTypeForm = "application/x-www-form-urlencoded";

  late final Dio _dio;

  HttpManager() {
    _dio = Dio(BaseOptions(baseUrl: Config.baseUrl));
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(ErrorInterceptors());
    // _dio.interceptors.add(TokenInterceptors());
    // if (kReleaseMode) {
    //   _dio.interceptors.add(talkerDioIntercepter);
    // }
  }

  /// 发起网络请求
  /// [ url ] 请求url，query参数拼接在url;
  /// [ params ] 请求体body参数;
  /// [ header ] 外加头, 一般通用的已经在header_interceptor加上了，这是为了特殊情况着想;
  /// [ option ] dio配置, 通过是get请求;
  Future<ResultData> fetch(
    String url, {
    Object? params,
    Map<String, dynamic>? header,
    Options? options,
  }) async {
    Map<String, dynamic> headers = HashMap();

    if (header != null) {
      headers.addAll(header);
    }

    // 默认 get 方法请求
    options ??= Options(method: "get");
    // 定义自定义头部
    options.headers = headers;

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
    } on DioException catch (e) {
      return HttpManager.handleError(e, url);
    }

    if (response.data is DioException) {
      return HttpManager.handleError(response.data as DioException, url);
    }

    return ResultData(response.data, null);
  }

  /// [url] 请求定制
  /// [query] query参数, 接受Map类型
  /// [options] DIO请求配置参数，自定义头写在options.headers 里面，headers为Map类型
  Future<ResultData> get(
    String url, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: query, options: options);
    } on DioException catch (e) {
      return HttpManager.handleError(e, url);
    }

    if (response.data is DioException) {
      return HttpManager.handleError(response.data as DioException, url);
    }

    return ResultData(response.data, null);
  }

  /// [url] 请求定制
  /// [data] data参数, 支持Map和FormData(FormData需要自己构造: FormData.fromMap()))
  /// [options] DIO请求配置参数，自定义头写在options.headers 里面，headers为Map类型
  Future<ResultData> post(
    String url, {
    Object? data,
    Options? options,
    bool useFormUrlencoded = false,
  }) async {
    options ??= Options();
    if (useFormUrlencoded) {
      options.contentType = HttpManager.contentTypeForm;
    }

    Response response;
    try {
      response = await _dio.post(url, data: data, options: options);
    } on DioException catch (e) {
      return HttpManager.handleError(e, url);
    }

    if (response.data is DioException) {
      return HttpManager.handleError(response.data as DioException, url);
    }

    return ResultData(response.data, null);
  }

  /// 错误处理
  static ResultData handleError(DioException e, String url) {
    Response? errorResponse;
    // 服务器返回的错误信息
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = Response(
        statusCode: -1,
        requestOptions: RequestOptions(path: url),
        data: {'code': -1, 'msg': '未知错误'},
      );
    }
    // 处理超时
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      errorResponse!.statusCode = Code.networkTimeout;
    }

    switch (errorResponse?.statusCode) {
      case Code.tokenExpired:
        errorResponse!.data = ErrorBuilder.fromJson(errorResponse.data);
      case Code.noAuthorization:
        if (errorResponse?.data == null) {
          errorResponse!.data = ErrorBuilder(
            code: Code.noAuthorization,
            msg: "暂无权限",
          );
        }
      case Code.notFound:
        errorResponse!.data = ErrorBuilder(code: Code.notFound, msg: "接口不存在");
      case Code.throttle:
        errorResponse!.data = ErrorBuilder(code: Code.throttle, msg: "接口限流");
      case Code.networkTimeout:
        errorResponse!.data = ErrorBuilder(
          code: Code.networkTimeout,
          msg: "请求超时",
        );
      default:
        errorResponse!.data = ErrorBuilder.fromJson(errorResponse.data);
    }
    return ResultData(null, errorResponse?.data);
  }
}

final HttpManager httpManager = HttpManager();
