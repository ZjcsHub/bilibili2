enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (pathStr.endsWith("/")) {
        pathStr += "$pathParams";
      } else {
        pathStr += "/$pathParams";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();
  // 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

  bool responseJson() {
    return true;
  }
}
