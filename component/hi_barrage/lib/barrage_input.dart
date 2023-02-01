import 'package:flutter/material.dart';

class BarrageInput extends StatelessWidget {
  final ValueChanged<String?>? onTabClose;
  const BarrageInput({Key? key, this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) {
                onTabClose!(null);
              }
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          SafeArea(
              child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                _buildInput(editingController, context),
                _buildSendBtn(editingController, context)
              ],
            ),
            color: Colors.white,
          ))
        ],
      ),
    );
  }

  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: MaterialColor(
            0xfffb7299, const <int, Color>{50: const Color(0xffff9db5)}),
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
            hintText: "发个友善的弹幕"),
      ),
    ));
  }

  _send(String value, BuildContext context) {
    if (onTabClose != null) {
      onTabClose!(value);
    }
    Navigator.pop(context);
  }

  _buildSendBtn(TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text.trim() ?? "";
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send,
          color: Colors.grey,
        ),
      ),
    );
  }
}
