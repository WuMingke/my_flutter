import 'package:my_flutter/learnimooc2/http/core/request_manager.dart';
import 'package:my_flutter/learnimooc2/http/core/response_manager.dart';
import 'package:my_flutter/learnimooc2/http/request/base_request.dart';

/// 测试适配器，mock数据
class MockAdapter extends RequestAdapter {
  @override
  Future<ProjectResponse<T>> send<T>(BaseRequest request) {
    print("执行 MockAdapter send");
    return Future.delayed(const Duration(milliseconds: 5000), () {
      return ProjectResponse(
        data: {"code": 1, "message": "success"} as T,
        statusCode: 500,
      );
    });
  }
}
