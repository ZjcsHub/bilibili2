import 'package:bilibili_test/main_defend.dart';
import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/util/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db/hi_cache.dart';

void main() {
  HiDefend().run(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Get.put(CustomTheme.getInstance());
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          theme.getThemeMode(isSet: true);
          return GetMaterialApp(
            themeMode: theme.getThemeMode(),
            theme: theme.white(),
            darkTheme: theme.black(),
            initialRoute: init_route(),
            getPages: ROUTER,
            enableLog: true,
            routingCallback: (route) {
              print(
                  "currentRoute:${route?.current},routeCurrent:${Get.currentRoute},previous:${route?.previous},routePrevious:${Get.previousRoute},removed:${route?.removed}");
              if (route?.current == video_detail) {
                theme.setToBlack();
              }
            },
          );
        }
        return Container();
      },
      future: HiCache.preInit(),
    );
  }
}
