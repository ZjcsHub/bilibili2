import '../../db/hi_cache.dart';

class LoginDao {
  static const String BOARDING_PASS = "boarding_pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String impocid, String orderId) {
    return _send(userName, password, impocid: impocid, orderid: orderId);
  }

  static _send(String userName, String password, {impocid, orderid}) {
    // BaseRequest request;
    // if (impocid != null && orderid != null) {
    //   request = RegistrationRequest();
    // } else {
    //   request = LoginRequest();
    // }
    // request
    //     .add("userName", userName)
    //     .add("password", password)
    //     .add("impocId", impocid)
    //     .add("orderId", orderid);
    // var result = await HiNet.getInstance().fire(request);
    // print(result);
    // if (result['code'] == 0 && result['data'] != null) {
    //   // 保存登录令牌
    // }
    // return result;
    var result = {'code': 0, 'data': 'Jckeats'};
    HiCache.getInstance().saveString(BOARDING_PASS, result['data'] as String);

    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().getString(BOARDING_PASS);
  }
}
