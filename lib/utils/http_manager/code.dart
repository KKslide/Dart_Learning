class Code {
  ///网络错误
  static const networkError = 0;

  ///网络超时
  static const networkTimeout = -9000;

  ///网络返回数据格式化一次
  static const networkJsonException = -3;
  // token过期
  static const tokenExpired = 401;
  // 无权限
  static const noAuthorization = 403;
  // 接口不存在
  static const notFound = 404;
  // 请求限流
  static const throttle = 429;

  static const success = 200;

  // static errorHandleFunction(code, message, noTip) {
  //   if (noTip) {
  //     return message;
  //   }

  //   eventBus.fire(HttpErrorEvent(code, message));
  //   return message;
  // }
}
