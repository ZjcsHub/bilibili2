import 'package:bilibili_test/http/dao/home_dao.dart';
import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/widget/hi_refresh.dart';
import 'package:bilibili_test/widget/hi_tab.dart';
import 'package:bilibili_test/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/video_data_model.dart';
import '../widget/loading_container.dart';
import '../widget/video_large_card.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var tabs = ['推荐', '娱乐', '影视'];
  late TabController _tabController;

  late ScrollController _scrollController;

  List<VideoData> valueDataLists = [];
  bool isRequest = false;

  @override
  void initState() {
    super.initState();
    print("init state");
    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController(); // listview 控制器
    _scrollController.addListener(_scrollviewListener);
  }

  _scrollviewListener() {
    print(
        "current:${_scrollController.position.pixels},max:${_scrollController.position.maxScrollExtent}");
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 20) {
      print("滑动到底部");
      _getData(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollviewListener);
  }

  Future<List<VideoData>?> _getData(bool getMore) async {
    List<VideoData> list = [];
    if (this.isRequest) {
      return list;
    }
    this.isRequest = true;
    try {
      var result = await HomeDao.getRankingData();
      if (result is VideoDataModel) {
        var videoDataLists = (result as VideoDataModel).data;
        list = videoDataLists ?? [];
      }
    } catch (e) {
      print(e);
    }
    this.isRequest = false;

    valueDataLists.addAll(list);
    if (getMore) {
      setState(() {});
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomNavigationBar(
            child: Container(
              child: HiTab(
                tabs.map((e) => Text(e)).toList(),
                controller: _tabController,
              ),
              alignment: Alignment.center,
            ),
          ),
          _buildTabView()
        ],
      ),
    );
  }

  _buildMoreWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("加载更多"),
          CircularProgressIndicator(
            strokeWidth: 1,
          )
        ],
      ),
    );
  }

  _buildTabView() {
    return Expanded(
        child: this.valueDataLists.isEmpty
            ? FutureBuilder(
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

                  return _mainContents(snapshot.data ?? []);
                },
                future: _getData(false),
              )
            : _mainContents(this.valueDataLists));
  }

  Widget _mainContents(List<VideoData> lists) {
    return TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return MediaQuery.removePadding(
            context: context,
            child: HiRefresh(
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var videoWidget = VideoLargeCard(
                    videoData: lists[index],
                    callback: (model) {
                      Get.toNamed(video_detail, arguments: model);
                    },
                  );
                  if (index == lists.length - 1) {
                    return Column(
                      children: [videoWidget, Divider(), _buildMoreWidget()],
                    );
                  }
                  return videoWidget;
                },
                itemCount: lists.length,
                controller: _scrollController,
              ),
              valucChanged: _onReflesh,
            ),
            removeTop: true,
          );
        }).toList());
  }

  Future _onReflesh() {
    print("下拉刷新");
    this.valueDataLists.clear();
    var d = Future.delayed(Duration(seconds: 0));
    setState(() {});
    return d;
  }

  @override
  bool get wantKeepAlive => true;
}
