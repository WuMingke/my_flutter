import 'package:dio/dio.dart';
import 'package:my_flutter/learnimooc2/http/core/request_manager.dart';
import 'package:my_flutter/learnimooc2/http/core/response_manager.dart';
import 'package:my_flutter/learnimooc2/http/request/base_request.dart';

import 'error_manager.dart';

/// dio适配器
class DioAdapter extends RequestAdapter {
  @override
  Future<ProjectResponse<T>> send<T>(BaseRequest request) async {
    Response? response;
    var option = Options(headers: request.header);
    Exception? error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: option);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(), data: request.params, options: option);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw ReqError(response?.statusCode ?? -1, error.toString(), data: _buildRes(response, request));
    }

    return _buildRes(response, request);
  }

  _buildRes(Response? response, BaseRequest request) {
    return ProjectResponse(
      data: response?.data,
      request: request,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
      extra: response?.extra,
    );
  }
}
