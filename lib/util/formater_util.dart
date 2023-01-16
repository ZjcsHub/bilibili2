/// 数字转换万
String countFormat(int count) {
  String views = "";
  if (count > 9999) {
    views = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    views = count.toString();
  }
  return views;
}

/// 将时间转换成秒换位为分钟：秒
String durationTransForm(int second) {
  int m = (second / 60).truncate();
  int s = second - m * 60;
  if (s < 10) {
    return '$m:0$s';
  }
  return '$m:$s';
}
