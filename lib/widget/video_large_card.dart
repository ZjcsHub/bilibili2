import 'package:flutter/material.dart';

import '../models/video_data_model.dart';
import '../util/formater_util.dart';
import '../util/view_util.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoData? videoData;
  final ValueChanged<VideoData?>? callback;
  const VideoLargeCard({Key? key, this.videoData, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.callback != null) {
          this.callback!(videoData);
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_itemImage(context), _itemText(context)],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoData?.pic ?? "",
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(2)),
                alignment: Alignment.centerRight,
                child: Text(
                  durationTransForm(int.parse(videoData?.duration ?? "0")),
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  _itemText(BuildContext context) {
    return Expanded(
        child: Container(
      height: 90,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoData?.title ?? "",
            maxLines: 2,
            style: TextStyle(fontSize: 13),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black26),
                    child: Text(
                      "UP",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    videoData?.author ?? "",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                  )
                ],
              ),
              hiSpace(height: 2),
              Row(
                children: [
                  ...smallIconText(
                      Icons.ondemand_video, countFormat(videoData?.play ?? 0)),
                  hiSpace(width: 2),
                  ...smallIconText(
                      Icons.list_alt, countFormat(videoData?.review ?? 0))
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
