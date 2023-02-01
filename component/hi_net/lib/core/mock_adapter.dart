import '../core/adapter.dart';
import '../request/base_request.dart';

/// 测试适配器，mock数据

class MockAdapter extends NetAdapter {
  @override
  Future<NetResponse> send<T>(BaseRequest request) {
    return Future.delayed(Duration(seconds: 2), () {
      return NetResponse({
        "statusCode": 200,
        "data": {"code": 0, "message": "success"}
      }, statusCode: 200);
    });
  }
}
