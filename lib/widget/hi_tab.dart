import 'package:flutter/material.dart';

class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double indicatorWeight;
  final double insets;
  final Color selectedLabelColor;
  final Color unselectedLabelColor;

  const HiTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 18,
      this.indicatorWeight = 3,
      this.insets = 10,
      this.selectedLabelColor = Colors.red,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: this.tabs,
      controller: controller,
      indicatorColor: selectedLabelColor,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      labelColor: selectedLabelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicatorWeight: indicatorWeight,
      labelStyle: TextStyle(fontSize: fontSize),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: selectedLabelColor, width: 3),
          insets: EdgeInsets.only(left: insets, right: insets)),
    );
  }
}
