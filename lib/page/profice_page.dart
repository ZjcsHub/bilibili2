import 'dart:convert';

import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/widget/darkmode_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/video_data_model.dart';
import '../util/view_util.dart';
import '../widget/banner.dart';
import '../widget/course_card.dart';
import '../widget/flex_header.dart';
import '../widget/hi_blur.dart';

class ProficePage extends StatefulWidget {
  const ProficePage({Key? key}) : super(key: key);

  @override
  State<ProficePage> createState() => _ProficePageState();
}

class _ProficePageState extends State<ProficePage> {
  ScrollController _controller = ScrollController();
  List<VideoData> banbnerLists = [];

  @override
  void initState() {
    super.initState();
    _buildBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [_buildSliver()];
        },
        body: _buildBody(),
      ),
    );
  }

  _buildSliver() {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      // 扩展高度
      expandedHeight: 200,
      // 标题栏是否固定
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, // 视察滚动
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: cachedImage(
                    "https://i0.hdslb.com/bfs/live/636d66a97d5f55099a9d8d6813558d6d4c95fd61.jpg",
                    width: size.width,
                    height: 160)),
            Positioned.fill(
                child: HiBlur(
              sigma: 20,
            )),
            Positioned(
              child: _buildProfileTab(),
              bottom: 0,
              left: 0,
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  _buildProfileTab() {
    return Container(
      decoration: BoxDecoration(color: Colors.white30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", 34),
          _buildIconText("点赞", 20),
          _buildIconText("浏览", 54),
          _buildIconText("金币", 407),
          _buildIconText("粉丝", "20万"),
        ],
      ),
    );
  }

  _buildIconText(String text, num) {
    return Column(
      children: [
        hiSpace(
          height: 10,
        ),
        Text(
          '$num',
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        hiSpace(height: 2),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        hiSpace(
          height: 10,
        ),
      ],
    );
  }

  _buildHead() {
    return HiFlexibleHeader(
        name: "我是用户名",
        face: "images/right_eys_open.png",
        controller: _controller);
  }

  _buildBody() {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              if (!banbnerLists.isEmpty) _buildBanner(),
              CourseCard(
                courseList: [
                  "https://i0.hdslb.com/bfs/feed-admin/90229c0ffc901aef1a913d87b3048df9c130a1e6.jpg",
                  "https://i0.hdslb.com/bfs/feed-admin/3cf225dd9f09209a1526aee69a7045ce772755e3.jpg",
                  "https://i0.hdslb.com/bfs/feed-admin/33ca4b820ff829d59561402bef3db08dbebc20cc.jpg",
                  "https://i0.hdslb.com/bfs/feed-admin/16af7c338b014f7a28775161506d9314d8e3ced1.png"
                ],
                title: "职场进阶",
                subTitle: "带你突破技术瓶颈",
              ),
              CourseCard(
                courseList: [
                  "https://i0.hdslb.com/bfs/sycp/creative_img/202203/5d447362aa3168cfb3bd9ee5882324f9.jpg",
                  "https://i0.hdslb.com/bfs/sycp/creative_img/202203/9480c0cb75f2580defb0d0d71ae6432d.jpg",
                  "https://i0.hdslb.com/bfs/sycp/creative_img/202203/779f4ae0b92f75f62730d621881fdd5c.jpeg"
                ],
                title: "广告推广",
                crossAxisCount: 1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: DarkModeItem(onclick: () {
                  Get.toNamed(theme_route);
                }),
              )
            ],
          ),
        ));
  }

  _buildBanner() {
    return HiBanner(
      bannerLists: banbnerLists,
      bannerHeight: 200,
    );
  }

  _buildBannerData() {
    // 获取json
    rootBundle.loadString("json/profice_banner.json").then((value) {
      List bannerLists = json.decode(value);
      var banbnerModelLists =
          bannerLists.map((e) => VideoData.fromJson(e)).toList();
      setState(() {
        banbnerLists = banbnerModelLists;
      });
    });
  }
}
