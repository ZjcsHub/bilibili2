import 'package:bilibili_test/page/home_page.dart';
import 'package:bilibili_test/page/profice_page.dart';
import 'package:bilibili_test/page/ranking_page.dart';
import 'package:bilibili_test/util/color.dart';
import 'package:flutter/material.dart';

import '../favorite_page.dart';

/// 底部导航
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  List<Widget> _pageList = [];

  @override
  void initState() {
    super.initState();
    _pageList = [
      HomePage(
        jumpToProfile: () {
          _jumptoIndex(3);
        },
      ),
      RankingPage(),
      FavoritePage(),
      ProficePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3)
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          print('当前选中：$index');
          _jumptoIndex(index);
        },
        selectedItemColor: _activeColor,
        unselectedItemColor: _defaultColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _jumptoIndex(index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  _bottomItem(String name, IconData icon, int i) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: name);
  }
}
