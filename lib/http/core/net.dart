import 'package:bilibili_test/http/core/adapter.dart';
import 'package:bilibili_test/http/core/dio_adapter.dart';
import 'package:bilibili_test/http/core/error.dart';
import 'package:bilibili_test/http/request/base_request.dart';

class Net {
  Net._();
  static Net? _instance;
  static Net getInstance() {
    if (_instance == null) {
      _instance = Net._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    NetResponse response;
    var error;
    try {
      response = await _send(request);
    } on NetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    }

    // if (response == null) {
    //   printLog(error);
    // }

    var result = response.data;
    // printLog(result);

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw NetError(status ?? -1, result.toString());
    }
  }

  /// 发送数据
  Future<dynamic> _send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');
    printLog('header:${request.header}');
    // return Future.value({
    //   'statusCode': 200,
    //   'data': {'code': 0, 'message': 'success'}
    // });
    // 使用mock发送了数据
    // NetAdapter adapter = MockAdapter();
    // return adapter.send(request);

    NetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('net:${log.toString()}');
  }
}
