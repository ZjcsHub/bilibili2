import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../models/video_detail_model.dart';
import '../util/formater_util.dart';
import '../util/view_util.dart';

/// 可展开组件
class ExpandableContent extends StatefulWidget {
  final VideoDetailModel detailModel;

  const ExpandableContent({Key? key, required this.detailModel})
      : super(key: key);

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false; // 不展开
  // 用来管理Animation
  late AnimationController _animationController;
  // 生成动画高度值
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _heightFactor = _animationController.drive(_easeInTween);
    _animationController.addListener(() {
      // 监听动画值变化
      print(_heightFactor.value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          _buildInfo(),
          _buildDes()
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent, // 透明色
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            widget.detailModel.data?.view?.title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
    );
  }

  _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        // 执行动画
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  _buildInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var time = widget.detailModel.data?.view?.ctime ?? 0;
    var dateFormater = formatDate(
        DateTime.fromMillisecondsSinceEpoch(time * 1000),
        [yyyy, '/', mm, '/', dd]);
    var viewsCounts =
        countFormat(widget.detailModel.data?.view?.stat?.view ?? 0);
    var reply = countFormat(widget.detailModel.data?.view?.stat?.reply ?? 0);
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, viewsCounts),
        hiSpace(width: 8),
        ...smallIconText(Icons.list_alt, reply),
        hiSpace(width: 8),
        Text(
          dateFormater,
          style: style,
        )
      ],
    );
  }

  _buildDes() {
    var child = _expand
        ? Text(
            widget.detailModel.data?.view?.desc ?? "没有描述",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor.value,
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
