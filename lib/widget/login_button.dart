import 'package:flutter/material.dart';

import '../util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool enable;
  const LoginButton(this.title, {Key? key, this.onPressed, this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: Colors.grey,
        color: primary,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
