import 'package:bilibili_test/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProficePage extends StatefulWidget {
  const ProficePage({Key? key}) : super(key: key);

  @override
  State<ProficePage> createState() => _ProficePageState();
}

class _ProficePageState extends State<ProficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人"),
      ),
      body: TextButton(
        onPressed: () {
          Get.toNamed(login_router);
        },
        child: Text("跳转"),
      ),
    );
  }
}
