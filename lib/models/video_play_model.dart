class VideoPlayModel {
  int? code;
  String? message;
  int? ttl;
  Data? data;

  VideoPlayModel({this.code, this.message, this.ttl, this.data});

  VideoPlayModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ttl = json['ttl'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['ttl'] = this.ttl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? from;
  String? result;
  String? message;
  int? quality;
  String? format;
  int? timelength;
  String? acceptFormat;
  List<String>? acceptDescription;
  List<int>? acceptQuality;
  int? videoCodecid;
  String? seekParam;
  String? seekType;
  List<Durl>? durl;

  Data({
    this.from,
    this.result,
    this.message,
    this.quality,
    this.format,
    this.timelength,
    this.acceptFormat,
    this.acceptDescription,
    this.acceptQuality,
    this.videoCodecid,
    this.seekParam,
    this.seekType,
    this.durl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    result = json['result'];
    message = json['message'];
    quality = json['quality'];
    format = json['format'];
    timelength = json['timelength'];
    acceptFormat = json['accept_format'];
    acceptDescription = json['accept_description'].cast<String>();
    acceptQuality = json['accept_quality'].cast<int>();
    videoCodecid = json['video_codecid'];
    seekParam = json['seek_param'];
    seekType = json['seek_type'];
    if (json['durl'] != null) {
      durl = [];
      json['durl'].forEach((v) {
        durl!.add(new Durl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['result'] = this.result;
    data['message'] = this.message;
    data['quality'] = this.quality;
    data['format'] = this.format;
    data['timelength'] = this.timelength;
    data['accept_format'] = this.acceptFormat;
    data['accept_description'] = this.acceptDescription;
    data['accept_quality'] = this.acceptQuality;
    data['video_codecid'] = this.videoCodecid;
    data['seek_param'] = this.seekParam;
    data['seek_type'] = this.seekType;
    if (this.durl != null) {
      data['durl'] = this.durl!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Durl {
  int? order;
  int? length;
  int? size;
  String? ahead;
  String? vhead;
  String? url;

  Durl({
    this.order,
    this.length,
    this.size,
    this.ahead,
    this.vhead,
    this.url,
  });

  Durl.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    length = json['length'];
    size = json['size'];
    ahead = json['ahead'];
    vhead = json['vhead'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['length'] = this.length;
    data['size'] = this.size;
    data['ahead'] = this.ahead;
    data['vhead'] = this.vhead;
    data['url'] = this.url;
    return data;
  }
}
