import 'package:bilibili_test/page/darkmode_page.dart';
import 'package:bilibili_test/page/login_page.dart';
import 'package:bilibili_test/page/navigator/bottom_navigator.dart';
import 'package:bilibili_test/page/registration_page.dart';
import 'package:bilibili_test/page/video_detail_page.dart';
import 'package:get/get.dart';

const register_router = '/register';
const main_router = "/";
const login_router = '/login';
const video_detail = '/detail';
const profile_route = '/progile';
const theme_route = "/theme";
var ROUTER = [
  GetPage(name: register_router, page: () => RegistrationPage()),
  GetPage(name: login_router, page: () => LoginPage()),
  GetPage(name: main_router, page: () => BottomNavigator()),
  GetPage(name: video_detail, page: () => VideoDetailPage()),
  GetPage(name: theme_route, page: () => DarkModePage())
];

init_route() {
  return main_router;
}
