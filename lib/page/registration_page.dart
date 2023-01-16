import 'package:bilibili_test/widget/appbar.dart';
import 'package:bilibili_test/widget/login_effect.dart';
import 'package:bilibili_test/widget/login_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/core/error.dart';
import '../http/dao/login_dao.dart';
import '../util/string_util.dart';
import '../util/toast.dart';
import '../widget/login_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _focus = false;

  bool loginEnable = false;
  String username = "";
  String password = "";
  String rePassword = "";
  String imoocId = "";
  String orderId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', () {
        Get.back();
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
            LoginInput(
              title: "确认密码",
              onChanged: (text) {
                print(text);
                rePassword = text;
                checkInput();
              },
              hint: "请再次输入密码",
              obscureText: true,
              focusChanged: (focus) {
                setState(() {
                  _focus = focus;
                });
              },
            ),
            LoginInput(
                title: "慕课网ID",
                onChanged: (text) {
                  print(text);
                  imoocId = text;
                  checkInput();
                },
                hint: "请输入你的慕课网用户ID",
                keboardType: TextInputType.number),
            LoginInput(
              title: "订单号",
              onChanged: (text) {
                print(text);
                orderId = text;
                checkInput();
              },
              hint: "请输入课程订单号后4位",
              keboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  checkInput() {
    var enable = isNotEmpty(username) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId);
    setState(() {
      this.loginEnable = enable;
    });
  }

  send() async {
    try {
      var result =
          await LoginDao.registration(username, password, imoocId, orderId);
      if (result["code"] == 0) {
        print("注册成功");
      } else {
        print(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on NetError catch (e) {
      print(e);
    }
  }

  checkParams() {
    String? tip;
    if (password != rePassword) {
      tip = "两次密码不一致";
    } else if (orderId.length != 4) {
      tip = "请输入订单号后4位";
    }
    print(tip);
    if (tip == null) {
      send();
    } else {
      showWarningToast(tip);
    }
  }

  _loginButton() {
    return LoginButton(
      "注册",
      onPressed: () {
        if (loginEnable) {
          checkParams();
        } else {
          print('数据不完整');
        }
      },
      enable: loginEnable,
    );
  }
}
