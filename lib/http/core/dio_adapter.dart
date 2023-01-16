import 'package:bilibili_test/http/core/adapter.dart';
import 'package:bilibili_test/http/core/error.dart';
import 'package:bilibili_test/http/request/base_request.dart';
import 'package:dio/dio.dart';

class DioAdapter extends NetAdapter {
  @override
  Future<NetResponse> send<T>(BaseRequest request) async {
    var response,
        option = Options(
            headers: request.header,
            responseType: request.responseJson()
                ? ResponseType.json
                : ResponseType.bytes);
    var error;
    try {
      switch (request.httpMethod()) {
        case HttpMethod.POST:
          response = await Dio()
              .post(request.url(), options: option, data: request.params);
          break;
        case HttpMethod.DELETE:
          response = await Dio()
              .delete(request.url(), options: option, data: request.params);
          break;
        case HttpMethod.GET:
          response = await Dio().get(request.url(), options: option);
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw NetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  buildRes(Response response, BaseRequest request) {
    return NetResponse(response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
