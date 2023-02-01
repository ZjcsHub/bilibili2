import 'package:flutter/material.dart';

import 'barrage_transition.dart';

class BarrageItem extends StatelessWidget {
  final String? id;
  final double top;
  final Widget? child;
  final ValueChanged? onComplete;
  final Duration duration;
  var _key = GlobalKey<BarrageTransitionState>();

  BarrageItem(
      {Key? key,
      this.id,
      this.top = 0,
      this.child,
      this.onComplete,
      this.duration = const Duration(seconds: 9)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
          key: _key,
          onComplete: (value) {
            if (onComplete != null) onComplete!(this);
          },
          duration: duration,
          child: child,
        ));
  }
}
