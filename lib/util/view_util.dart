import 'package:bilibili_test/util/theme_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

/// 带缓存的图片
Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

/// 黑色线性渐变
blackLinearGradient({bool fromtop = false}) {
  return LinearGradient(
      begin: fromtop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromtop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent,
      ]);
}

setStatusBar(Color color, StatusStyle statusStyle) async {
  // 沉浸式状态栏
  await StatusBarControl.setColor(color, animated: false);
  await StatusBarControl.setStyle(statusStyle == StatusStyle.Dark
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
}

smallIconText(IconData data, String text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);

  return [
    Icon(
      data,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      text,
      style: style,
    )
  ];
}

borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey[200]!);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

SizedBox hiSpace({double height = 1, double width = 1}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
