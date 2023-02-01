import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../util/view_util.dart';
import 'asperct_raio_image.dart';

class CourseCard extends StatelessWidget {
  final List<String>? courseList;
  final String title;
  final String subTitle;
  final int crossAxisCount;
  // final double mainAxisCellCount;
  const CourseCard({
    Key? key,
    this.courseList,
    this.title = "",
    this.subTitle = "",
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildTitle(), _buildCardList(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            subTitle,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _getShowData(context),
    );
  }

  List<Widget> _getShowData(BuildContext context) {
    if (courseList == null) return [];

    return courseList?.map((e) {
      // return StaggeredGridTile.count(
      //     crossAxisCellCount: 1,
      //     mainAxisCellCount: mainAxisCellCount,
      //     child: cachedImage(e));
      return AsperctRaioImage.network(e, builder: (context, snapshot, url) {
        double width = snapshot.data?.width.toDouble() ?? 1;
        double height = snapshot.data?.height.toDouble() ?? 1;
        return StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: height / width,
            child: cachedImage(url));
      });
    }).toList() as List<Widget>;
  }
}
