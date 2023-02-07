import 'dart:convert';

import 'package:my_flutter/learnimooc2/http/request/base_request.dart';

/// 统一网络层返回格式
class ProjectResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  ProjectResponse({this.data, this.request, this.statusCode, this.statusMessage, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
