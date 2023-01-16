import 'dart:math';

import 'video_detail_model.dart';
import 'package:date_format/date_format.dart';

class VideoDataModel {
  int? code;
  String? message;
  int? ttl;
  List<VideoData>? data;

  VideoDataModel({this.code, this.message, this.ttl, this.data});

  VideoDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ttl = json['ttl'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new VideoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['ttl'] = this.ttl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoData {
  String? aid;
  String? bvid;
  String? typename;
  String? title;
  String? subtitle;
  int? play;
  int? review;
  int? videoReview;
  int? favorites;
  int? mid;
  String? author;
  String? description;
  String? create;
  String? pic;
  int? coins;
  String? duration;
  bool badgepay = false;
  int? pts;
  Rights? rights;
  String? redirectUrl;

  VideoData(
      {this.aid = "",
      this.bvid = "",
      this.typename = "",
      this.title = "",
      this.subtitle = "",
      this.play = 0,
      this.review = 0,
      this.videoReview = 0,
      this.favorites = 0,
      this.mid = 0,
      this.author = "",
      this.description = "",
      this.create = "",
      this.pic = "",
      this.coins = 0,
      this.duration = "",
      this.badgepay = false,
      this.pts = 0,
      this.rights,
      this.redirectUrl = ""});

  VideoData.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    bvid = json['bvid'];
    typename = json['typename'];
    title = json['title'];
    subtitle = json['subtitle'];
    play = json['play'];
    review = json['review'];
    videoReview = json['video_review'];
    favorites = json['favorites'];
    mid = json['mid'];
    author = json['author'];
    description = json['description'];
    create = json['create'];
    pic = json['pic'];
    coins = json['coins'];
    duration = json['duration'];
    badgepay = json['badgepay'];
    pts = json['pts'];
    rights =
        json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['bvid'] = this.bvid;
    data['typename'] = this.typename;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['play'] = this.play;
    data['review'] = this.review;
    data['video_review'] = this.videoReview;
    data['favorites'] = this.favorites;
    data['mid'] = this.mid;
    data['author'] = this.author;
    data['description'] = this.description;
    data['create'] = this.create;
    data['pic'] = this.pic;
    data['coins'] = this.coins;
    data['duration'] = this.duration;
    data['badgepay'] = this.badgepay;
    data['pts'] = this.pts;
    if (this.rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    data['redirect_url'] = this.redirectUrl;
    return data;
  }

  VideoData.transFrom(Related? related) {
    aid = related?.aid.toString();
    bvid = related?.bvid;
    typename = related?.tname;
    title = related?.title;
    subtitle = related?.desc;
    play = related?.stat?.view;
    review = related?.stat?.reply;
    favorites = related?.stat?.favorite;
    author = related?.owner?.name;
    description = related?.desc;
    create = formatDate(
        DateTime.fromMillisecondsSinceEpoch((related?.ctime ?? 0) * 1000),
        [yyyy, '/', mm, '/', dd, " ", HH, ":", nn, ":", ss]);
    pic = related?.pic;
    coins = related?.stat?.coin;
    duration = related?.duration.toString();
    rights = related?.rights;
    redirectUrl = related?.redirectUrl;
  }
}

// class Rights {
//   int? bp;
//   int? elec;
//   int? download;
//   int? movie;
//   int? pay;
//   int? hd5;
//   int? noReprint;
//   int? autoplay;
//   int? ugcPay;
//   int? isCooperation;
//   int? ugcPayPreview;
//   int? noBackground;
//
//   Rights(
//       {this.bp,
//       this.elec,
//       this.download,
//       this.movie,
//       this.pay,
//       this.hd5,
//       this.noReprint,
//       this.autoplay,
//       this.ugcPay,
//       this.isCooperation,
//       this.ugcPayPreview,
//       this.noBackground});
//
//   Rights.fromJson(Map<String, dynamic> json) {
//     bp = json['bp'];
//     elec = json['elec'];
//     download = json['download'];
//     movie = json['movie'];
//     pay = json['pay'];
//     hd5 = json['hd5'];
//     noReprint = json['no_reprint'];
//     autoplay = json['autoplay'];
//     ugcPay = json['ugc_pay'];
//     isCooperation = json['is_cooperation'];
//     ugcPayPreview = json['ugc_pay_preview'];
//     noBackground = json['no_background'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bp'] = this.bp;
//     data['elec'] = this.elec;
//     data['download'] = this.download;
//     data['movie'] = this.movie;
//     data['pay'] = this.pay;
//     data['hd5'] = this.hd5;
//     data['no_reprint'] = this.noReprint;
//     data['autoplay'] = this.autoplay;
//     data['ugc_pay'] = this.ugcPay;
//     data['is_cooperation'] = this.isCooperation;
//     data['ugc_pay_preview'] = this.ugcPayPreview;
//     data['no_background'] = this.noBackground;
//     return data;
//   }
// }
