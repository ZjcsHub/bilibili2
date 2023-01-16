import 'package:bilibili_test/util/color.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String? hint;
  final ValueChanged<String> onChanged;
  final ValueChanged? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keboardType;

  const LoginInput(
      {Key? key,
      required this.title,
      this.hint,
      required this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keboardType})
      : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 是否获取光标的监听
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
              padding: EdgeInsets.only(left: 15),
              width: 100,
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.keboardType,
        autofocus: !widget.obscureText,
        cursorColor: primary,
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            border: InputBorder.none,
            hintText: widget.hint ?? "",
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }
}
