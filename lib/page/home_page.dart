import 'dart:async';

import 'package:bilibili_test/core/hi_state.dart';
import 'package:bilibili_test/http/dao/home_dao.dart';
import 'package:bilibili_test/models/video_data_model.dart';
import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/util/theme_data.dart';
import 'package:bilibili_test/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/hi_tab.dart';
import '../widget/navigation_bar.dart';
import 'home_tab_page.dart';

class HomePage extends StatefulWidget {
  VoidCallback? jumpToProfile;

  HomePage({Key? key, this.jumpToProfile}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver,
        TickerProviderStateMixin {
  var change = false;
  var tabs = ['推荐', '娱乐', '影视', '电影', '电视剧'];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    print("didChangePlatformBrightness");
    final CustomTheme theme = Get.put(CustomTheme.getInstance());
    theme.darModeChange();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState:${state}");
    switch (state) {
      case AppLifecycleState.resumed:
        print("后台切换到前台，界面可见");
        if (Get.currentRoute == video_detail) {
          CustomTheme theme = Get.put(CustomTheme.getInstance());
          theme.setToBlack();
        }
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<List<VideoData>?> _getData() async {
    try {
      var result = await HomeDao.homeGet();
      if (result is VideoDataModel) {
        var videoDataLists = (result as VideoDataModel).data;
        print(videoDataLists);
        return videoDataLists;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    print("build ---- ");
    return Scaffold(
      body: Column(
        children: [
          CustomNavigationBar(
            child: _appBar(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: _tabBar(),
          ),
          Flexible(
              child: FutureBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<List<VideoData>?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return LoadingContainer(
                    isLoading: true,
                  );

                case ConnectionState.done:
                  break;
                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
              }

              return TabBarView(
                  controller: _controller,
                  children: tabs
                      .map((e) => HomeTabPage(
                            name: e,
                            bannerLists: snapshot.data ?? [],
                          ))
                      .toList());
            },
            future: _getData(),
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _appBar() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("点击");
              if (widget.jumpToProfile != null) {
                widget.jumpToProfile!();
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("images/left_eys_open.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          GestureDetector(
            onTap: () {
              print("点击explore_outlined");
            },
            child: Icon(Icons.explore_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                print("点击mail_outline");
              },
              child: Icon(Icons.mail_outline),
            ),
          )
        ],
      ),
    );
  }

  _tabBar() {
    // return TabBar(
    //   tabs: tabs
    //       .map((e) => Tab(
    //             child: Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: Text(
    //                 e,
    //                 style: const TextStyle(fontSize: 20),
    //               ),
    //             ),
    //           ))
    //       .toList(),
    //   controller: _controller,
    //   isScrollable: true,
    //   indicator: UnderlineTabIndicator(
    //       borderSide: BorderSide(color: primary, width: 3),
    //       insets: EdgeInsets.only(left: 15, right: 15)),
    // );
    return HiTab(
      tabs
          .map((e) => Tab(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    e,
                  ),
                ),
              ))
          .toList(),
      controller: _controller,
    );
  }

  _catchError() {
    runZonedGuarded(() {
      throw StateError('runZonedGuarded:This is a dart exception');
    }, (e, s) => print(e));

    runZonedGuarded(() {
      Future.delayed(Duration(seconds: 1)).then((value) => throw StateError(
          "runZonedGuarded:This is a dart exception in future"));
    }, (e, s) => print(e));
  }
}
