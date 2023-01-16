import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/theme_data.dart';

class CustomNavigationBar extends StatelessWidget {
  final StatusStyle? statusStyle;

  final Color? color;

  final double height;
  final Widget? child;
  final bool showShadow;
  const CustomNavigationBar(
      {Key? key,
      this.statusStyle,
      this.color,
      this.height = 56,
      this.child,
      this.showShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取provider
    CustomTheme theme = Get.put(CustomTheme.getInstance());
    print("current : ${theme.appbarBackColor.value}");
    var setColor = color ?? Colors.black;
    if (color == null || statusStyle == null) {
      setColor = Color(theme.appbarBackColor.value);
    }
    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.height + top,
      child: this.child,
      decoration: BoxDecoration(
        color: setColor,
        boxShadow: this.showShadow
            ? [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影模糊程度
                    spreadRadius: 2.0 //阴影扩散程度
                    )
              ]
            : null,
      ),
      padding: EdgeInsets.only(top: top),
    );
  }
}
