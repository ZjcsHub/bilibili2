import 'package:bilibili_test/util/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeItem extends StatelessWidget {
  final VoidCallback onclick;
  const DarkModeItem({Key? key, required this.onclick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Get.put(CustomTheme.getInstance());
    var icon =
        theme.isDarkMode() ? Icons.nightlight_round : Icons.wb_sunny_rounded;
    return InkWell(
      onTap: onclick,
      child: Container(
        child: Row(
          children: [
            Text(
              theme.isDarkMode() ? "夜间模式" : "白天模式",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 10),
              child: Icon(icon),
            )
          ],
        ),
      ),
    );
  }
}
