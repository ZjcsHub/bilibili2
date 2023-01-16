import 'package:bilibili_test/routers/routers.dart';
import 'package:bilibili_test/widget/login_button.dart';
import 'package:bilibili_test/widget/login_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/dao/login_dao.dart';
import '../util/string_util.dart';
import '../widget/appbar.dart';
import '../widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _focus = false;

  bool loginEnable = false;
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        Get.toNamed(register_router);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: _focus),
            LoginInput(
              title: "用户名",
              onChanged: (text) {
                print(text);
                username = text;
                checkInput();
              },
              hint: "请输入用户名",
            ),
            LoginInput(
              title: "密码",
              onChanged: (text) {
                print(text);
                password = text;
                checkInput();
              },
              hint: "请输入密码",
              obscureText: true,
              focusChanged: (focus) {
                setState(() {
                  _focus = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                "登录",
                enable: loginEnable,
                onPressed: () {
                  send();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  checkInput() {
    var enable = isNotEmpty(username) && isNotEmpty(password);
    setState(() {
      this.loginEnable = enable;
    });
  }

  send() {
    print("username:$username,password:$password");
    var result = LoginDao.login(username, password) as Map;
    print("result:$result");
    if (result["code"] == 0) {
      print("登录成功");
    } else {
      print(result['msg']);
    }
  }
}
