import 'package:flutter/material.dart';

import '../util/view_util.dart';

class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;
  const HiFlexibleHeader(
      {Key? key,
      required this.name,
      required this.face,
      required this.controller})
      : super(key: key);

  @override
  State<HiFlexibleHeader> createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double Max_bottom = 60;
  static const double Min_bottom = 10;
  // 滚动范围
  static const Max_offset = 100;

  double _dyBottom = Max_bottom;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      print('offset:$offset');
      // 算出padding变化
      var dyOffset = (Max_offset - offset) / Max_offset;
      // 根据dyoffset算出具体变化的padding值
      var dy = dyOffset * (Max_bottom - Min_bottom);
      // 临界保护
      if (dy > (Max_bottom - Min_bottom)) {
        dy = Max_bottom - Min_bottom;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        // 算出实际padding
        _dyBottom = Min_bottom + dy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildHead();
  }

  _buildHead() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _dyBottom, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image(
              image: AssetImage(widget.face),
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
          ),
          hiSpace(width: 8),
          Text(
            widget.name,
            style: TextStyle(fontSize: 18, color: Colors.red),
          )
        ],
      ),
    );
  }
}
