import 'package:bilibili_test/widget/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nested/flutter_nested.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../models/video_data_model.dart';
import '../routers/routers.dart';
import '../widget/video_card.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  List<VideoData> bannerLists = [];

  HomeTabPage({Key? key, required this.name, required this.bannerLists})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: _fiveBuildSecondView(),
      removeTop: true,
    );
  }

  _banner() {
    final sizeWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: HiBanner(
          bannerHeight: 0.43 * sizeWidth,
          bannerLists: widget.bannerLists,
        ));
  }

  // 第一种建造模式
  _contentsBody() {
    return ListView(
      children: [
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: _getShowData(),
        )
      ],
    );
  }

  List<Widget> _getShowData() {
    List<Widget> li = [];
    if (!widget.bannerLists.isEmpty) {
      li.add(StaggeredGridTile.count(
          crossAxisCellCount: 2, mainAxisCellCount: 1, child: _banner()));
      widget.bannerLists.forEach((element) {
        li.add(StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 0.8,
            child: VideoCard(
              videoData: element,
              valueChanged: (videoModel) {
                print("点击 ${videoModel}");
                Get.toNamed(video_detail, arguments: videoModel);
              },
            )));
      });
    }
    return li;
  }

  // 第二种建造模式 ，缺陷是下拉时banner不会动
  _secondBuildView() {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: CustomScrollView(
        slivers: [
          if (!widget.bannerLists.isEmpty)
            SliverPersistentHeader(
              delegate: _MySliverPersistentHeaderDelegate(widget.bannerLists),
            ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return VideoCard(
                videoData: widget.bannerLists[index],
                valueChanged: (videoModel) {
                  Get.toNamed(video_detail, arguments: videoModel);
                },
              );
            }, childCount: widget.bannerLists.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0, //主轴中间间距
              crossAxisSpacing: 4.0, //副轴中间间距
              childAspectRatio: 1.2, //item 宽高比
            ),
          )
        ],
      ),
    );
  }

  // 第3种模式
  _thirdBuildView() {
    return GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          pattern: [
            WovenGridTile(1.2),
            WovenGridTile(1.2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          if (index > widget.bannerLists.length) return null;
          return VideoCard(
            videoData: widget.bannerLists[index],
            valueChanged: (videoModel) {
              print("点击 ${videoModel}");
              Get.toNamed(video_detail, arguments: videoModel);
            },
          );
        }));
  }

  // 第4种
  _forthBuildView() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return VideoCard(
          videoData: widget.bannerLists[index],
          valueChanged: (videoModel) {
            print("点击 ${videoModel}");
            Get.toNamed(video_detail, arguments: videoModel);
          },
        );
      },
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: widget.bannerLists.length,
    );
  }

  // 第5种
  _fiveBuildSecondView() {
    // return HiNestedScrollView
    return HiNestedScrollView(
      headers: [
        if (!widget.bannerLists.isEmpty) _banner(),
        SizedBox(height: 10)
      ],
      itemCount: widget.bannerLists.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.2),
      itemBuilder: (BuildContext context, int index) {
        return VideoCard(
          videoData: widget.bannerLists[index],
          valueChanged: (videoModel) {
            print("点击 ${videoModel}");
            Get.toNamed(video_detail, arguments: videoModel);
          },
        );
      },
    );
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent = 165;
  final double _maxExtent = 165;

  final List<VideoData> bannerList;

  _MySliverPersistentHeaderDelegate(this.bannerList);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //创建child子组件
    //shrinkOffset：child偏移值minExtent~maxExtent
    //overlapsContent：SliverPersistentHeader覆盖其他子组件返回true，否则返回false
    print('shrinkOffset = $shrinkOffset overlapsContent = $overlapsContent');
    return HiBanner(
      bannerLists: bannerList,
      valueChanged: (videoModel) {
        print("点击：${videoModel}");
      },
    );
  }

  //SliverPersistentHeader最大高度
  @override
  double get maxExtent => _maxExtent;

  //SliverPersistentHeader最小高度
  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
