class VideoDetailModel {
  int? code;
  String? message;
  int? ttl;
  Data? data;

  VideoDetailModel({this.code, this.message, this.ttl, this.data});

  VideoDetailModel.fromJson(Map<String, dynamic> json) {
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
  View? view;

  List<Tags>? tags;

  List<Related>? related;

  Data({this.view, this.tags, this.related});

  Data.fromJson(Map<String, dynamic> json) {
    view = json['View'] != null ? new View.fromJson(json['View']) : null;

    if (json['Tags'] != null) {
      tags = [];
      json['Tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['Related'] != null) {
      related = [];
      json['Related'].forEach((v) {
        related!.add(new Related.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.view != null) {
      data['View'] = this.view!.toJson();
    }

    if (this.tags != null) {
      data['Tags'] = this.tags!.map((v) => v.toJson()).toList();
    }

    if (this.related != null) {
      data['Related'] = this.related!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class View {
  String? bvid;
  int? aid;
  int? videos;
  int? tid;
  String? tname;
  int? copyright;
  String? pic;
  String? title;
  int? pubdate;
  int? ctime;
  String? desc;
  List<DescV2>? descV2;
  int? state;
  int? duration;
  Rights? rights;
  Owner? owner;
  Stat? stat;
  String? ddynamic;
  int? cid;
  Dimension? dimension;
  int? seasonId;
  bool? noCache;
  List<Pages>? pages;
  Subtitle? subtitle;
  Label? label;
  UgcSeason? ugcSeason;
  bool? isSeasonDisplay;

  View({
    this.bvid,
    this.aid,
    this.videos,
    this.tid,
    this.tname,
    this.copyright,
    this.pic,
    this.title,
    this.pubdate,
    this.ctime,
    this.desc,
    this.descV2,
    this.state,
    this.duration,
    this.rights,
    this.owner,
    this.stat,
    this.ddynamic,
    this.cid,
    this.dimension,
    this.seasonId,
    this.noCache,
    this.pages,
    this.subtitle,
    this.label,
    this.ugcSeason,
    this.isSeasonDisplay,
  });

  View.fromJson(Map<String, dynamic> json) {
    bvid = json['bvid'];
    aid = json['aid'];
    videos = json['videos'];
    tid = json['tid'];
    tname = json['tname'];
    copyright = json['copyright'];
    pic = json['pic'];
    title = json['title'];
    pubdate = json['pubdate'];
    ctime = json['ctime'];
    desc = json['desc'];
    if (json['desc_v2'] != null) {
      descV2 = [];
      json['desc_v2'].forEach((v) {
        descV2!.add(new DescV2.fromJson(v));
      });
    }
    state = json['state'];
    duration = json['duration'];
    rights =
        json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
    ddynamic = json['dynamic'];
    cid = json['cid'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
    seasonId = json['season_id'];
    noCache = json['no_cache'];
    if (json['pages'] != null) {
      pages = [];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
    subtitle = json['subtitle'] != null
        ? new Subtitle.fromJson(json['subtitle'])
        : null;
    label = json['label'] != null ? new Label.fromJson(json['label']) : null;
    ugcSeason = json['ugc_season'] != null
        ? new UgcSeason.fromJson(json['ugc_season'])
        : null;
    isSeasonDisplay = json['is_season_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bvid'] = this.bvid;
    data['aid'] = this.aid;
    data['videos'] = this.videos;
    data['tid'] = this.tid;
    data['tname'] = this.tname;
    data['copyright'] = this.copyright;
    data['pic'] = this.pic;
    data['title'] = this.title;
    data['pubdate'] = this.pubdate;
    data['ctime'] = this.ctime;
    data['desc'] = this.desc;
    if (this.descV2 != null) {
      data['desc_v2'] = this.descV2!.map((v) => v.toJson()).toList();
    }
    data['state'] = this.state;
    data['duration'] = this.duration;
    if (this.rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    data['dynamic'] = this.ddynamic;
    data['cid'] = this.cid;
    if (this.dimension != null) {
      data['dimension'] = this.dimension!.toJson();
    }
    data['season_id'] = this.seasonId;
    data['no_cache'] = this.noCache;
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    if (this.subtitle != null) {
      data['subtitle'] = this.subtitle!.toJson();
    }
    if (this.label != null) {
      data['label'] = this.label!.toJson();
    }
    if (this.ugcSeason != null) {
      data['ugc_season'] = this.ugcSeason!.toJson();
    }
    data['is_season_display'] = this.isSeasonDisplay;

    return data;
  }
}

class DescV2 {
  String? rawText;
  int? type;
  int? bizId;

  DescV2({this.rawText, this.type, this.bizId});

  DescV2.fromJson(Map<String, dynamic> json) {
    rawText = json['raw_text'];
    type = json['type'];
    bizId = json['biz_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw_text'] = this.rawText;
    data['type'] = this.type;
    data['biz_id'] = this.bizId;
    return data;
  }
}

class Rights {
  int? bp;
  int? elec;
  int? download;
  int? movie;
  int? pay;
  int? hd5;
  int? noReprint;
  int? autoplay;
  int? ugcPay;
  int? isCooperation;
  int? ugcPayPreview;
  int? noBackground;
  int? cleanMode;
  int? isSteinGate;
  int? is360;
  int? noShare;

  Rights(
      {this.bp,
      this.elec,
      this.download,
      this.movie,
      this.pay,
      this.hd5,
      this.noReprint,
      this.autoplay,
      this.ugcPay,
      this.isCooperation,
      this.ugcPayPreview,
      this.noBackground,
      this.cleanMode,
      this.isSteinGate,
      this.is360,
      this.noShare});

  Rights.fromJson(Map<String, dynamic> json) {
    bp = json['bp'];
    elec = json['elec'];
    download = json['download'];
    movie = json['movie'];
    pay = json['pay'];
    hd5 = json['hd5'];
    noReprint = json['no_reprint'];
    autoplay = json['autoplay'];
    ugcPay = json['ugc_pay'];
    isCooperation = json['is_cooperation'];
    ugcPayPreview = json['ugc_pay_preview'];
    noBackground = json['no_background'];
    cleanMode = json['clean_mode'];
    isSteinGate = json['is_stein_gate'];
    is360 = json['is_360'];
    noShare = json['no_share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bp'] = this.bp;
    data['elec'] = this.elec;
    data['download'] = this.download;
    data['movie'] = this.movie;
    data['pay'] = this.pay;
    data['hd5'] = this.hd5;
    data['no_reprint'] = this.noReprint;
    data['autoplay'] = this.autoplay;
    data['ugc_pay'] = this.ugcPay;
    data['is_cooperation'] = this.isCooperation;
    data['ugc_pay_preview'] = this.ugcPayPreview;
    data['no_background'] = this.noBackground;
    data['clean_mode'] = this.cleanMode;
    data['is_stein_gate'] = this.isSteinGate;
    data['is_360'] = this.is360;
    data['no_share'] = this.noShare;
    return data;
  }
}

class Owner {
  int? mid;
  String? name;
  String? face;

  Owner({this.mid, this.name, this.face});

  Owner.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    name = json['name'];
    face = json['face'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['face'] = this.face;
    return data;
  }
}

class Stat {
  int? aid;
  int? view;
  int? danmaku;
  int? reply;
  int? favorite;
  int? coin;
  int? share;
  int? nowRank;
  int? hisRank;
  int? like;
  int? dislike;
  String? evaluation;
  String? argueMsg;

  Stat(
      {this.aid,
      this.view,
      this.danmaku,
      this.reply,
      this.favorite,
      this.coin,
      this.share,
      this.nowRank,
      this.hisRank,
      this.like,
      this.dislike,
      this.evaluation,
      this.argueMsg});

  Stat.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    view = json['view'];
    danmaku = json['danmaku'];
    reply = json['reply'];
    favorite = json['favorite'];
    coin = json['coin'];
    share = json['share'];
    nowRank = json['now_rank'];
    hisRank = json['his_rank'];
    like = json['like'];
    dislike = json['dislike'];
    evaluation = json['evaluation'];
    argueMsg = json['argue_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['view'] = this.view;
    data['danmaku'] = this.danmaku;
    data['reply'] = this.reply;
    data['favorite'] = this.favorite;
    data['coin'] = this.coin;
    data['share'] = this.share;
    data['now_rank'] = this.nowRank;
    data['his_rank'] = this.hisRank;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}

class Dimension {
  int? width;
  int? height;
  int? rotate;

  Dimension({this.width, this.height, this.rotate});

  Dimension.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    rotate = json['rotate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['rotate'] = this.rotate;
    return data;
  }
}

class Pages {
  int? cid;
  int? page;
  String? from;
  String? part;
  int? duration;
  String? vid;
  String? weblink;
  Dimension? dimension;
  String? firstFrame;

  Pages(
      {this.cid,
      this.page,
      this.from,
      this.part,
      this.duration,
      this.vid,
      this.weblink,
      this.dimension,
      this.firstFrame});

  Pages.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    page = json['page'];
    from = json['from'];
    part = json['part'];
    duration = json['duration'];
    vid = json['vid'];
    weblink = json['weblink'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
    firstFrame = json['first_frame'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['page'] = this.page;
    data['from'] = this.from;
    data['part'] = this.part;
    data['duration'] = this.duration;
    data['vid'] = this.vid;
    data['weblink'] = this.weblink;
    if (this.dimension != null) {
      data['dimension'] = this.dimension!.toJson();
    }
    data['first_frame'] = this.firstFrame;
    return data;
  }
}

class Subtitle {
  bool? allowSubmit;

  Subtitle({this.allowSubmit});

  Subtitle.fromJson(Map<String, dynamic> json) {
    allowSubmit = json['allow_submit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_submit'] = this.allowSubmit;

    return data;
  }
}

class Label {
  int? type;

  Label({this.type});

  Label.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class UgcSeason {
  int? id;
  String? title;
  String? cover;
  int? mid;
  String? intro;
  int? signState;
  int? attribute;
  List<Sections>? sections;
  Stat? stat;
  int? epCount;
  int? seasonType;

  UgcSeason(
      {this.id,
      this.title,
      this.cover,
      this.mid,
      this.intro,
      this.signState,
      this.attribute,
      this.sections,
      this.stat,
      this.epCount,
      this.seasonType});

  UgcSeason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    mid = json['mid'];
    intro = json['intro'];
    signState = json['sign_state'];
    attribute = json['attribute'];
    if (json['sections'] != null) {
      sections = [];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
    epCount = json['ep_count'];
    seasonType = json['season_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['mid'] = this.mid;
    data['intro'] = this.intro;
    data['sign_state'] = this.signState;
    data['attribute'] = this.attribute;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    data['ep_count'] = this.epCount;
    data['season_type'] = this.seasonType;
    return data;
  }
}

class Sections {
  int? seasonId;
  int? id;
  String? title;
  int? type;

  Sections({this.seasonId, this.id, this.title, this.type});

  Sections.fromJson(Map<String, dynamic> json) {
    seasonId = json['season_id'];
    id = json['id'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season_id'] = this.seasonId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;

    return data;
  }
}

class Tags {
  int? tagId;
  String? tagName;
  String? cover;
  String? headCover;
  String? content;
  String? shortContent;
  int? type;
  int? state;
  int? ctime;
  Count? count;
  int? isAtten;
  int? likes;
  int? hates;
  int? attribute;
  int? liked;
  int? hated;
  int? extraAttr;
  String? tagType;
  bool? isActivity;
  String? color;
  int? alpha;
  bool? isSeason;
  int? subscribedCount;
  String? archiveCount;
  int? featuredCount;
  String? jumpUrl;

  Tags(
      {this.tagId,
      this.tagName,
      this.cover,
      this.headCover,
      this.content,
      this.shortContent,
      this.type,
      this.state,
      this.ctime,
      this.count,
      this.isAtten,
      this.likes,
      this.hates,
      this.attribute,
      this.liked,
      this.hated,
      this.extraAttr,
      this.tagType,
      this.isActivity,
      this.color,
      this.alpha,
      this.isSeason,
      this.subscribedCount,
      this.archiveCount,
      this.featuredCount,
      this.jumpUrl});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
    cover = json['cover'];
    headCover = json['head_cover'];
    content = json['content'];
    shortContent = json['short_content'];
    type = json['type'];
    state = json['state'];
    ctime = json['ctime'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    isAtten = json['is_atten'];
    likes = json['likes'];
    hates = json['hates'];
    attribute = json['attribute'];
    liked = json['liked'];
    hated = json['hated'];
    extraAttr = json['extra_attr'];
    tagType = json['tag_type'];
    isActivity = json['is_activity'];
    color = json['color'];
    alpha = json['alpha'];
    isSeason = json['is_season'];
    subscribedCount = json['subscribed_count'];
    archiveCount = json['archive_count'];
    featuredCount = json['featured_count'];
    jumpUrl = json['jump_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    data['cover'] = this.cover;
    data['head_cover'] = this.headCover;
    data['content'] = this.content;
    data['short_content'] = this.shortContent;
    data['type'] = this.type;
    data['state'] = this.state;
    data['ctime'] = this.ctime;
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['is_atten'] = this.isAtten;
    data['likes'] = this.likes;
    data['hates'] = this.hates;
    data['attribute'] = this.attribute;
    data['liked'] = this.liked;
    data['hated'] = this.hated;
    data['extra_attr'] = this.extraAttr;
    data['tag_type'] = this.tagType;
    data['is_activity'] = this.isActivity;
    data['color'] = this.color;
    data['alpha'] = this.alpha;
    data['is_season'] = this.isSeason;
    data['subscribed_count'] = this.subscribedCount;
    data['archive_count'] = this.archiveCount;
    data['featured_count'] = this.featuredCount;
    data['jump_url'] = this.jumpUrl;
    return data;
  }
}

class Count {
  int? view;
  int? use;
  int? atten;

  Count({this.view, this.use, this.atten});

  Count.fromJson(Map<String, dynamic> json) {
    view = json['view'];
    use = json['use'];
    atten = json['atten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view'] = this.view;
    data['use'] = this.use;
    data['atten'] = this.atten;
    return data;
  }
}

class Related {
  int? aid;
  int? videos;
  int? tid;
  String? tname;
  int? copyright;
  String? pic;
  String? title;
  int? pubdate;
  int? ctime;
  String? desc;
  int? state;
  int? duration;
  Rights? rights;
  Owner? owner;
  Stat? stat;
  String? ddynamic;
  int? cid;
  Dimension? dimension;
  String? shortLink;
  String? shortLinkV2;
  String? firstFrame;
  String? bvid;
  int? seasonType;
  bool? isOgv;

  String? rcmdReason;
  int? seasonId;
  int? missionId;
  int? upFromV2;
  String? redirectUrl;

  Related(
      {this.aid,
      this.videos,
      this.tid,
      this.tname,
      this.copyright,
      this.pic,
      this.title,
      this.pubdate,
      this.ctime,
      this.desc,
      this.state,
      this.duration,
      this.rights,
      this.owner,
      this.stat,
      this.ddynamic,
      this.cid,
      this.dimension,
      this.shortLink,
      this.shortLinkV2,
      this.firstFrame,
      this.bvid,
      this.seasonType,
      this.isOgv,
      this.rcmdReason,
      this.seasonId,
      this.missionId,
      this.upFromV2,
      this.redirectUrl});

  Related.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    videos = json['videos'];
    tid = json['tid'];
    tname = json['tname'];
    copyright = json['copyright'];
    pic = json['pic'];
    title = json['title'];
    pubdate = json['pubdate'];
    ctime = json['ctime'];
    desc = json['desc'];
    state = json['state'];
    duration = json['duration'];
    rights =
        json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
    ddynamic = json['dynamic'];
    cid = json['cid'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
    shortLink = json['short_link'];
    shortLinkV2 = json['short_link_v2'];
    firstFrame = json['first_frame'];
    bvid = json['bvid'];
    seasonType = json['season_type'];
    isOgv = json['is_ogv'];
    rcmdReason = json['rcmd_reason'];
    seasonId = json['season_id'];
    missionId = json['mission_id'];
    upFromV2 = json['up_from_v2'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['videos'] = this.videos;
    data['tid'] = this.tid;
    data['tname'] = this.tname;
    data['copyright'] = this.copyright;
    data['pic'] = this.pic;
    data['title'] = this.title;
    data['pubdate'] = this.pubdate;
    data['ctime'] = this.ctime;
    data['desc'] = this.desc;
    data['state'] = this.state;
    data['duration'] = this.duration;
    if (this.rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    data['dynamic'] = this.ddynamic;
    data['cid'] = this.cid;
    if (this.dimension != null) {
      data['dimension'] = this.dimension!.toJson();
    }
    data['short_link'] = this.shortLink;
    data['short_link_v2'] = this.shortLinkV2;
    data['first_frame'] = this.firstFrame;
    data['bvid'] = this.bvid;
    data['season_type'] = this.seasonType;
    data['is_ogv'] = this.isOgv;
    data['rcmd_reason'] = this.rcmdReason;
    data['season_id'] = this.seasonId;
    data['mission_id'] = this.missionId;
    data['up_from_v2'] = this.upFromV2;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
