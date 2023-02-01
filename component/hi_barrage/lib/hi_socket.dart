import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

import 'barrage_model.dart';

/// 负责与后端进行websocket通信
class HiSocket implements ISocket {
  static const _URL = "";

  IOWebSocketChannel? _channel;
  ValueChanged<List>? _callBack;

  /// 心跳间隔秒数
  final int _intervalSecond = 50;

  @override
  void close() {
    if (_channel != null) {
      _channel?.sink.close();
    }
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack as ValueChanged<List>?;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSecond));
    _channel?.stream.handleError((error) {
      print("连接错误:$error");
    }).listen((event) {
      _handleMessage(event);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  _headers() {
    Map<String, dynamic> header = {};
    return header;
  }

  _handleMessage(message) {
    print('received:$message');
    // 处理返回信息
  }
}

abstract class ISocket {
  /// 和服务器进行连接
  ISocket open(String vid);

  /// 发送弹幕
  ISocket send(String message);

  /// 关闭连接
  void close();

  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
