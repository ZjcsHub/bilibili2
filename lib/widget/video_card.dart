import 'package:flutter/material.dart';

import '../models/video_data_model.dart';
import '../util/formater_util.dart';
import '../util/view_util.dart';

class VideoCard extends StatelessWidget {
  final VideoData? videoData;
  final ValueChanged<VideoData?>? valueChanged;
  const VideoCard({Key? key, this.videoData, this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.valueChanged != null) {
          this.valueChanged!(this.videoData);
        }
      },
      // child: Container(
      //   height: 500,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     image: DecorationImage(
      //         image: NetworkImage(this.videoData?.pic ?? ""),
      //         fit: BoxFit.cover),
      //   ),
      // ),
      child: Card(
        // 取消卡片边距
        // margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _infoText()],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // FadeInImage.memoryNetwork(
        //   height: size.width / 2 * 0.45,
        //   // 宽度
        //   width: size.width / 2,
        //   placeholder: kTransparentImage,
        //   image: this.videoData?.pic ?? "",
        //   fit: BoxFit.cover,
        // ),
        cachedImage(this.videoData?.pic ?? "",
            height: sizeWidth / 2 * 0.43, width: sizeWidth / 2),
        Positioned(
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, this.videoData?.play ?? 0),
                _iconText(
                    Icons.favorite_border, this.videoData?.favorites ?? 0),
                _iconText(null, 0)
              ],
            ),
          ),
          bottom: 0,
          left: 0,
          right: 0,
          height: 30,
        )
      ],
    );
  }

  _iconText(IconData? iconData, int count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = this.videoData?.duration ?? "";
    }
    return Row(
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.videoData?.title ?? "",
            maxLines: 2,
            style: TextStyle(fontSize: 15),
          ),
          _owner()
        ],
      ),
    ));
    return Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8),
      child: Text(
        this.videoData?.title ?? "",
        maxLines: 2,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  _owner() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          this.videoData?.author ?? "",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
