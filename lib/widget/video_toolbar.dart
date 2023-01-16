/// 视频的点赞分享工具栏
import "package:flutter/material.dart";

import '../models/video_detail_model.dart';
import '../util/color.dart';
import '../util/formater_util.dart';
import '../util/view_util.dart';

class VideoToolBar extends StatefulWidget {
  final VideoDetailModel detailModel;

  final VoidCallback? onLike;
  final VoidCallback? onUnlike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  const VideoToolBar(this.detailModel,
      {Key? key,
      this.onLike,
      this.onUnlike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  _VideoToolBarState createState() => _VideoToolBarState();
}

class _VideoToolBarState extends State<VideoToolBar>
    with TickerProviderStateMixin {
  Map maplists = {
    "like": {},
    "unLike": {},
    "coin": {},
    "favorite": {},
    "share": {}
  };

  late Tween<double> _tween;
  @override
  void initState() {
    super.initState();
    _tween = Tween(begin: 0.7, end: 1);
    var keys = maplists.keys;
    keys.forEach((element) {
      print(element);
      var controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      var animation = CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
          reverseCurve: Curves.elasticInOut);

      controller.forward();
      var map = {"animationController": controller, "animation": animation};
      maplists[element] = map;
    });
  }

  @override
  void dispose() {
    super.dispose();
    maplists.forEach((key, value) {
      (value["animationController"] as AnimationController).dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded,
              widget.detailModel.data?.view?.stat?.like,
              tint: true,
              onClick: widget.onLike,
              animationController: maplists["like"]["animationController"],
              animation: maplists["like"]["animation"]),
          _buildIconText(Icons.thumb_down_alt_rounded, "不喜欢",
              onClick: widget.onUnlike,
              animationController: maplists["unLike"]["animationController"],
              animation: maplists["unLike"]["animation"]),
          _buildIconText(
              Icons.monetization_on, widget.detailModel.data?.view?.stat?.coin,
              onClick: widget.onCoin),
          _buildIconText(Icons.grade_rounded,
              widget.detailModel.data?.view?.stat?.favorite,
              onClick: widget.onFavorite),
          _buildIconText(
              Icons.share_rounded, widget.detailModel.data?.view?.stat?.share,
              onClick: widget.onShare)
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text,
      {onClick,
      bool tint = false,
      AnimationController? animationController,
      Animation<double>? animation}) {
    if (text is int) {
      // 显示格式化
      text = countFormat(text);
    } else if (text == null) {
      text = "";
    }
    tint = tint == null ? false : tint;
    return animation != null
        ? ScaleTransition(
            scale: _tween.animate(animation),
            child: GestureDetector(
                // 取消点击阴影
                onTap: () {
                  animationController?.repeat();
                  setState(() {
                    animationController?.forward();
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      iconData,
                      color: tint ? primary : Colors.grey,
                    ),
                    hiSpace(height: 5),
                    Text(
                      text,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                )),
          )
        : GestureDetector(
            // 取消点击阴影
            onTap: () {
              animationController?.repeat();
              setState(() {
                animationController?.forward();
              });
            },
            child: Column(
              children: [
                Icon(
                  iconData,
                  color: tint ? primary : Colors.grey,
                ),
                hiSpace(height: 5),
                Text(
                  text,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ));
  }
}
