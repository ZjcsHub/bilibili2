import 'package:flutter/material.dart';

/// 登录动效
class LoginEffect extends StatefulWidget {
  final bool protect;

  const LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            image: AssetImage("images/logo.png"),
            height: 90,
            width: 120,
          ),
          _image(false)
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect
        ? 'images/left_eys_close.png'
        : 'images/left_eys_open.png';

    var headRight = widget.protect
        ? 'images/right_eys_close.png'
        : 'images/right_eys_open.png';

    return Image(
      image: AssetImage(left ? headLeft : headRight),
      height: 90,
    );
  }
}
