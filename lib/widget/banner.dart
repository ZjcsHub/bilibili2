import 'package:bilibili_test/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import '../models/video_data_model.dart';

class HiBanner extends StatelessWidget {
  final List<VideoData> bannerLists;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<VideoData>? valueChanged;

  const HiBanner(
      {Key? key,
      required this.bannerLists,
      this.bannerHeight = 200,
      this.padding,
      this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerLists.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerLists[index]);
      },
      // 指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(VideoData bannerModel) {
    return InkWell(
      onTap: () {
        Get.toNamed(video_detail, arguments: bannerModel);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)), // 圆角
          child: Image.network(
            bannerModel.pic ?? "",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
