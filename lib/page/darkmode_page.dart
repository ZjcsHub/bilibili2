import 'package:bilibili_test/util/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/color.dart';

/// 夜间模式页面

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _Items = [
    {
      "name": "跟随系统",
      "mode": CustomThemeMode.system,
    },
    {
      "name": "开启",
      "mode": CustomThemeMode.black,
    },
    {
      "name": "关闭",
      "mode": CustomThemeMode.white,
    }
  ];

  var _currentTheme;
  CustomTheme _customtheme = Get.put(CustomTheme.getInstance());

  @override
  void initState() {
    super.initState();
    var themeMode = _customtheme.getCustomThemeMode();
    print("当前主题时$themeMode");
    _currentTheme =
        _Items.firstWhere((element) => element["mode"] == themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: _Items.length),
    );
  }

  Widget _item(int index) {
    var theme = _Items[index];

    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(theme["name"] as String),
            ),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  _switchTheme(int index) {
    var theme = _Items[index];
    var changeMode = theme["mode"] as CustomThemeMode;
    print("将要改变的theme:$changeMode");
    _customtheme.setTheme(changeMode);
    setState(() {
      _currentTheme = theme;
    });
  }
}
