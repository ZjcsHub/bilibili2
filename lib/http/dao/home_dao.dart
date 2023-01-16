import 'package:bilibili_test/http/core/net.dart';
import 'package:bilibili_test/http/request/home_request.dart';
import 'package:bilibili_test/models/video_data_model.dart';

import '../../models/video_detail_model.dart';
import '../../models/video_play_model.dart';
import '../request/video_detail_request.dart';
import '../request/video_play_request.dart';

class HomeDao {
  static homeGet() async {
    var request = HomeRequest();
    request.add("rid", 1);
    var result = await Net.getInstance().fire(request);
    var videoModel = VideoDataModel.fromJson(result);
    return videoModel;
  }

  static detailGet(String aid, String bvid) async {
    var request = VideoDetailRequest();
    request.add("aid", aid).add("bvid", bvid);
    var result = await Net.getInstance().fire(request);

    var detailModel = VideoDetailModel.fromJson(result);

    return detailModel;
  }

  static videoPlayGet(int avid, int cid) async {
    var request = VideoPlayRequest();
    // qn=16&type=mp4&platform=html5
    request
        .add("avid", avid)
        .add("cid", cid)
        .add("qn", 16)
        .add("type", "mp4")
        .add("platform", "html5");
    var result = await Net.getInstance().fire(request);
    var model = VideoPlayModel.fromJson(result);

    return model;
  }
}
