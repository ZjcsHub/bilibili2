import 'package:flutter/material.dart';

class BarrageTransition extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final ValueChanged onComplete;
  const BarrageTransition(
      {Key? key,
      required this.child,
      required this.duration,
      required this.onComplete})
      : super(key: key);

  @override
  State<BarrageTransition> createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addStatusListener((state) {
            // 动画执行完毕后的回调
            if (state == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });

    var begin = Offset(1.0, 0);
    var end = Offset(-1, 0);
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
