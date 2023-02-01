library hi_barrage;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'barrage_item.dart';
import 'barrage_model.dart';
import 'barrage_view_util.dart';
import 'hi_socket.dart';
import 'ibarrage.dart';

enum BarrageStatus { play, pause }

/// 弹幕组建
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  const HiBarrage(
      {Key? key,
      this.lineCount = 4,
      required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  State<HiBarrage> createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  HiSocket? _hiSocket;
  double _height = 0;
  double _width = 0;
  List<BarrageItem> _barrageItemList = []; // 弹幕widget集合
  List<BarrageModel> _barrageModelList = []; // 弹幕模型

  int _barrageIndex = 0; // 第几条弹幕
  Random _random = Random();
  BarrageStatus? _barrageStatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _hiSocket = HiSocket();
    _hiSocket?.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    if (_hiSocket != null) {
      _hiSocket?.close();
    }

    if (_timer != null) {
      _timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          //防止Stack的child为空
          Container()
        ]..addAll(_barrageItemList),
      ),
    );
  }

  _handleMessage(List<BarrageModel> list, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, list);
    } else {
      _barrageModelList.addAll(list);
    }
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }

    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  addBarrage(BarrageModel model) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    //为每一条弹幕生成id
    String id = "${_random.nextInt(100000)}:${model.context}";
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: (value) {
        print("Done:${value.id}");
        _barrageItemList.removeWhere((element) => element.id == value.id);
      },
      duration: Duration(milliseconds: model.duration),
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    _barrageItemList.clear();
    setState(() {});
    print("action:pause");
    _timer?.cancel();
  }

  @override
  void send(String message) {
    _hiSocket?.send(message);
    _handleMessage([BarrageModel(message, widget.vid, 9000)]);
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("action:play");
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("start : ${temp.context}");
      } else {
        _timer?.cancel();
      }
    });
  }
}
