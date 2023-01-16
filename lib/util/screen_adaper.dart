import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper {
  late BuildContext _context;

  static ScreenAdaper? _instance;
  static ScreenAdaper getInstance() {
    if (_instance == null) {
      _instance = ScreenAdaper();
    }
    return _instance!;
  }

  init(context) {
    ScreenUtil.init(context);
    _context = context;
    // ScreenUtil.init(
    //     BoxConstraints(
    //       maxWidth: MediaQuery.of(context).size.width,
    //       maxHeight: MediaQuery.of(context).size.height
    //     ),
    //     designSize: Size(360, 690),
    //     minTextAdapt: true,
    //   orientation: Orientation.portrait
    // );
    //
    // ScreenUtil.setContext(context);
    // _context = context;
  }

  static height(num height) {
    ScreenUtil().setHeight(height);
  }

  static width(num width) {
    ScreenUtil().setWidth(width);
  }

  // 屏幕高度
  double getScreenHeight() {
    return ScreenUtil().screenHeight;
    // return MediaQuery.of(_context).size.height;
  }

  // 屏幕宽度
  double getScreenWidth() {
    return ScreenUtil().screenWidth;
    // return MediaQuery.of(_context).size.width;
  }
}
