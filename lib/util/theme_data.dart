import 'package:bilibili_test/util/color.dart';
import 'package:bilibili_test/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../db/hi_cache.dart';

enum CustomThemeMode { system, white, black }

enum StatusStyle { Light, Dark }

class CustomTheme extends GetxController {
  static CustomTheme? _instance;
  static CustomTheme getInstance() {
    if (_instance == null) {
      _instance = CustomTheme();
      _instance?.getThemeMode(isSet: true);
    }
    return _instance!;
  }

  late ThemeMode _themeMode;
  var appbarBackColor = 0xFFFFFFFF.obs;
  var stateStyle = StatusStyle.Light.obs;
  var _platFormBrightness = SchedulerBinding.instance.window.platformBrightness;

  bool isDarkMode() {
    var isDark = false;
    if (_themeMode == ThemeMode.system) {
      // 系统darkmode
      var systemBrightness =
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.dark;
      isDark = systemBrightness;
    } else {
      isDark = _themeMode == ThemeMode.dark;
    }
    return isDark;
  }

  ThemeMode getThemeMode({bool isSet = false}) {
    String? theme = HiCache.getInstance().getString("themeMode");
    switch (theme) {
      case 'black':
        _themeMode = ThemeMode.dark;
        if (isSet) {
          appbarBackColor.value = 0xff18191a;
          stateStyle.value = StatusStyle.Dark;
          setStatusBar(Colors.white, stateStyle.value);
        }
        break;

      case 'white':
        _themeMode = ThemeMode.light;
        if (isSet) {
          appbarBackColor.value = 0xFFFFFFFF;
          stateStyle.value = StatusStyle.Light;
          setStatusBar(Colors.black, stateStyle.value);
        }
        break;
      default:
        _themeMode = ThemeMode.system;
        if (isSet) {
          print("IS Set");
          if (isDarkMode()) {
            appbarBackColor.value = 0xff18191a;
            stateStyle.value = StatusStyle.Light;
            setStatusBar(Colors.white, stateStyle.value);
          } else {
            appbarBackColor.value = 0xFFFFFFFF;
            stateStyle.value = StatusStyle.Dark;
            setStatusBar(Colors.black, stateStyle.value);
          }
        }
        break;
    }

    return _themeMode;
  }

  setTheme(CustomThemeMode themeMode) {
    switch (themeMode) {
      case CustomThemeMode.white:
        Get.changeTheme(this.white());
        HiCache.getInstance().saveString("themeMode", 'white');
        break;
      case CustomThemeMode.black:
        Get.changeTheme(this.black());
        HiCache.getInstance().saveString("themeMode", 'black');
        break;
      case CustomThemeMode.system:
        HiCache.getInstance().saveString("themeMode", 'system');

        break;
    }
    Get.changeThemeMode(getThemeMode());
    getThemeMode(isSet: true);
  }

  void darModeChange() {
    if (_platFormBrightness !=
        SchedulerBinding.instance.window.platformBrightness) {
      _platFormBrightness = SchedulerBinding.instance.window.platformBrightness;

      if (getThemeMode() == ThemeMode.system) {
        getThemeMode(isSet: true);
      }
    }
  }

  setToDafault() {
    getThemeMode(isSet: true);
  }

  setToBlack() {
    setStatusBar(Colors.white, StatusStyle.Light);
  }

  ThemeData white() {
    return ThemeData(
      brightness: Brightness.light,
      errorColor: HiColor.red,
      primaryColor: Colors.white,
      indicatorColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, foregroundColor: Colors.black),
    );
  }

  ThemeData black() {
    return ThemeData(
        brightness: Brightness.dark,
        errorColor: HiColor.dark_red,
        primaryColor: HiColor.dark_bg,
        indicatorColor: primary,
        scaffoldBackgroundColor: HiColor.dark_bg,
        appBarTheme: AppBarTheme(
            backgroundColor: HiColor.dark_bg, foregroundColor: Colors.white));
  }
}
