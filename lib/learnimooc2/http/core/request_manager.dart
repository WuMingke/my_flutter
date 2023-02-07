import 'package:my_flutter/learnimooc2/http/core/dio_adapter.dart';
import 'package:my_flutter/learnimooc2/http/core/response_manager.dart';
import 'package:my_flutter/learnimooc2/http/request/base_request.dart';

import 'error_manager.dart';

class RequestManager {
  RequestManager._();

  static late final RequestManager _instance = RequestManager._();

  factory RequestManager() => _instance;

  Future fire(BaseRequest request) async {
    print("执行fire");
    ProjectResponse? response;
    var error;
    try {
      response = await send(request);
    } on ReqError catch (e) {
      error = e;
      response = e.data;
      print("---error on ReqError:${e.message}");
    } catch (e) {
      // 其它异常
      error = e;
      print("---error other:${e.toString()}");
    }

    if (response == null) {
      print("---response == null,error:${error.toString()}");
    }
    var result = response?.data;

    var status = response?.statusCode ?? -99999;
    switch (status) {
      case 200:
        print("--fire中的-result:$result");
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result?.toString() ?? "需要授权的异常", data: result);
      default:
        throw ReqError(status, response?.statusMessage ?? "", data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    print("执行send");
    print("---url:${request.url()}");
    print("---method:${request.httpMethod()}");
    request.addHeader("token", "123");
    print("---header:${request.header}");
    // return Future.value({
    //   "statusCode": 200,
    //   "data": {"code": 0, "message": "success"}
    // });
    // 切换成测试数据
    // RequestAdapter adapter = MockAdapter();
    RequestAdapter adapter = DioAdapter();
    return adapter.send(request);
  }
}

/// 网络请求抽象类
abstract class RequestAdapter {
  Future<ProjectResponse<T>> send<T>(BaseRequest request);
}
