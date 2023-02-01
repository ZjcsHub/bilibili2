import 'package:flutter/material.dart';

import 'barrage_model.dart';

class BarrageViewUtil {
  static barrageView(BarrageModel model) {
    return Text(
      model.context,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
