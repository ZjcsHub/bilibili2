import 'package:bilibili_test/models/video_detail_model.dart';
import 'package:bilibili_test/util/color.dart';
import 'package:bilibili_test/util/formater_util.dart';
import 'package:flutter/material.dart';

class VideoHeader extends StatelessWidget {
  final Owner? owner;

  const VideoHeader({Key? key, this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  width: 30,
                  height: 30,
                  image: NetworkImage(owner?.face ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner?.name ?? "Keats",
                      style: TextStyle(
                          fontSize: 13,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('${countFormat(owner?.mid ?? 0)}粉丝')
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              print("关注");
            },
            child: Text(
              "+ 关注",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            color: primary,
            height: 30,
            minWidth: 50,
          )
        ],
      ),
    );
  }
}
