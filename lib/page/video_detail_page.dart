import 'package:bilibili_test/http/dao/home_dao.dart';
import 'package:bilibili_test/models/video_data_model.dart';
import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/util/theme_data.dart';
import 'package:bilibili_test/widget/appbar.dart';
import 'package:bilibili_test/widget/hi_tab.dart';
import 'package:bilibili_test/widget/navigation_bar.dart';
import 'package:bilibili_test/widget/video_header.dart';
import 'package:bilibili_test/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/video_detail_model.dart';
import '../models/video_play_model.dart';
import '../widget/expandable_contents.dart';
import '../widget/video_large_card.dart';
import '../widget/video_toolbar.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({Key? key}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  VideoDetailModel? _detailModel;
  VideoPlayModel? _playModel;
  VideoData? _videoData;

  late TabController _controller;
  List tabs = ["简介", "评论288"];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    _getDetailData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getDetailData() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments is VideoData) {
      _videoData = arguments;
      try {
        _detailModel =
            await HomeDao.detailGet(arguments.aid ?? "", arguments.bvid ?? "");
        _getVideoPlayData();
      } catch (e) {
        print("get detail data error :$e");
      }
    }
  }

  _getVideoPlayData() async {
    try {
      var result = await HomeDao.videoPlayGet(
          _detailModel?.data?.view?.aid ?? 0,
          _detailModel?.data?.view?.cid ?? 0);
      if (result is VideoPlayModel) {
        setState(() {
          _playModel = result;
        });
      }
    } catch (e) {
      print("get video play data error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    VideoData videoModel = Get.arguments;
    print('detail arguments：${videoModel}');
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        child: Column(
          children: [
            CustomNavigationBar(
              color: Colors.black,
              statusStyle: StatusStyle.Light,
              height: top,
            ),
            _videoView(),
            _tabNavigtion(),
            Flexible(
                child: TabBarView(
              children: [
                _detailLists(),
                Container(
                  child: Text("敬请期待"),
                )
              ],
              controller: _controller,
            ))
          ],
        ),
        removeTop: true,
      ),
    );
  }

  _videoView() {
    if (_playModel != null) {
      return VideoView(
        url: _playModel!.data?.durl?.first.url ?? "",
        cover: _videoData?.pic ?? "",
        overlayUi: videoAppBar(callback: () {
          CustomTheme theme = Get.find();

          theme.setToDafault();
          Get.back();
        }),
      );
    } else {
      return Container(
        height: 200,
      );
    }
  }

  _tabNavigtion() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabbar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabbar() {
    return HiTab(
      tabs
          .map((e) => Tab(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    e,
                    // style: const TextStyle(fontSize: 20),
                  ),
                ),
              ))
          .toList(),
      controller: _controller,
      fontSize: 18,
    );
  }

  _detailLists() {
    return ListView(
      padding: EdgeInsets.all(0),
      // children: buildContents(),
      children: _buildContents(),
    );
  }

  List<Widget> _buildContents() {
    if (_detailModel == null) {
      return [];
    }
    return [
      VideoHeader(owner: _detailModel!.data!.view!.owner!),
      ExpandableContent(
        detailModel: _detailModel!,
      ),
      VideoToolBar(_detailModel!),
      ..._buildVideoList()
    ];
  }

  _buildVideoList() {
    return _detailModel!.data?.related?.map((e) {
      return VideoLargeCard(
        videoData: VideoData.transFrom(e),
        callback: (model) {
          print("call back ：$model");
          Get.offNamed(video_detail,
              preventDuplicates: false, arguments: model);
        },
      );
    }).toList() as List<Widget>;
  }
}
