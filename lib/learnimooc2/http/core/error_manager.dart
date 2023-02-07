/// 需要登录的异常
class NeedLogin extends ReqError {
  NeedLogin({String message = "请先登录", int code = 401, dynamic data}) : super(code, message, data: data);
}

/// 需要授权的异常
class NeedAuth extends ReqError {
  NeedAuth(String message, {int code = 403, dynamic data}) : super(code, message, data: data);
}

/// 网络异常统一格式类
class ReqError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  ReqError(this.code, this.message, {this.data});

  @override
  String toString() {
    return "ReqError---code:$code,message:$message,data:$data";
  }
}
