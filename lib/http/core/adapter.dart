import 'dart:convert';

import 'package:bilibili_test/http/request/base_request.dart';

abstract class NetAdapter {
  Future<NetResponse> send<T>(BaseRequest request);
}

class NetResponse<T> {
  NetResponse(this.data,
      {this.request, this.statusCode: 0, this.statusMessage: "", this.extra});

  T data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
