import 'dart:convert';

HostThumbListModel hostThumbListModelFromJson(String str) => HostThumbListModel.fromJson(json.decode(str));
String hostThumbListModelToJson(HostThumbListModel data) => json.encode(data.toJson());

class HostThumbListModel {
  HostThumbListModel({
    bool? status,
    String? message,
    List<Host>? host,
  }) {
    _status = status;
    _message = message;
    _host = host;
  }

  HostThumbListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['host'] != null) {
      _host = [];
      json['host'].forEach((v) {
        _host?.add(Host.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Host>? _host;
  HostThumbListModel copyWith({
    bool? status,
    String? message,
    List<Host>? host,
  }) =>
      HostThumbListModel(
        status: status ?? _status,
        message: message ?? _message,
        host: host ?? _host,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Host>? get host => _host;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_host != null) {
      map['host'] = _host?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Host hostFromJson(String str) => Host.fromJson(json.decode(str));
String hostToJson(Host data) => json.encode(data.toJson());

class Host {
  Host({
    String? id,
    String? name,
    String? uniqueID,
    String? token,
    String? channel,
    String? country,
    int? coin,
    int? age,
    String? image,
    List<String>? album,
    String? coverImage,
    String? liveStreamingId,
    int? agoraUid,
    bool? isFake,
    String? status,
    Rate? rate,
  }) {
    _id = id;
    _name = name;
    _uniqueID = uniqueID;
    _token = token;
    _channel = channel;
    _country = country;
    _coin = coin;
    _age = age;
    _image = image;
    _album = album;
    _coverImage = coverImage;
    _liveStreamingId = liveStreamingId;
    _agoraUid = agoraUid;
    _isFake = isFake;
    _status = status;
    _rate = rate;
  }

  Host.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _uniqueID = json['uniqueID'];
    _token = json['token'];
    _channel = json['channel'];
    _country = json['country'];
    _coin = json['coin'];
    _age= json['age'];
    _image = json['image'];
    _album = json['album'] != null ? json['album'].cast<String>() : [];
    _coverImage = json['coverImage'];
    _liveStreamingId = json['liveStreamingId'];
    _agoraUid = json['agoraUid'];
    _isFake = json['isFake'];
    _status = json['status'];
    _rate = json['rate'] != null ? Rate.fromJson(json['rate']) : null;
  }
  String? _id;
  String? _name;
  String? _uniqueID;
  String? _token;
  String? _channel;
  String? _country;
  int? _coin;
  int? _age;
  String? _image;
  List<String>? _album;
  String? _coverImage;
  String? _liveStreamingId;
  int? _agoraUid;
  bool? _isFake;
  String? _status;
  Rate? _rate;
  Host copyWith({
    String? id,
    String? name,
    String? uniqueID,
    String? token,
    String? channel,
    String? country,
    int? coin,
    int? age,
    String? image,
    List<String>? album,
    String? coverImage,
    String? liveStreamingId,
    int? agoraUid,
    bool? isFake,
    String? status,
    Rate? rate,
  }) =>
      Host(
        id: id ?? _id,
        name: name ?? _name,
        uniqueID: uniqueID ?? _uniqueID,
        token: token ?? _token,
        channel: channel ?? _channel,
        country: country ?? _country,
        coin: coin ?? _coin,
        age: age ?? _age,
        image: image ?? _image,
        album: album ?? _album,
        coverImage: coverImage ?? _coverImage,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
        agoraUid: agoraUid ?? _agoraUid,
        isFake: isFake ?? _isFake,
        status: status ?? _status,
        rate: rate ?? _rate,
      );
  String? get id => _id;
  String? get name => _name;
  String? get uniqueID => _uniqueID;
  String? get token => _token;
  String? get channel => _channel;
  String? get country => _country;
  int? get coin => _coin;
  int? get age => _age;
  String? get image => _image;
  List<String>? get album => _album;
  String? get coverImage => _coverImage;
  String? get liveStreamingId => _liveStreamingId;
  int? get agoraUid => _agoraUid;
  bool? get isFake => _isFake;
  String? get status => _status;
  Rate? get rate => _rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['uniqueID'] = _uniqueID;
    map['token'] = _token;
    map['channel'] = _channel;
    map['country'] = _country;
    map['coin'] = _coin;
    map['age'] = _age;
    map['image'] = _image;
    map['album'] = _album;
    map['coverImage'] = _coverImage;
    map['liveStreamingId'] = _liveStreamingId;
    map['agoraUid'] = _agoraUid;
    map['isFake'] = _isFake;
    map['status'] = _status;
    if (_rate != null) {
      map['rate'] = _rate?.toJson();
    }
    return map;
  }
}

Rate rateFromJson(String str) => Rate.fromJson(json.decode(str));
String rateToJson(Rate data) => json.encode(data.toJson());

class Rate {
  Rate({
    int? count,
    int? rate,
  }) {
    _count = count;
    _rate = rate;
  }

  Rate.fromJson(dynamic json) {
    _count = json['count'];
    _rate = json['rate'];
  }
  int? _count;
  int? _rate;
  Rate copyWith({
    int? count,
    int? rate,
  }) =>
      Rate(
        count: count ?? _count,
        rate: rate ?? _rate,
      );
  int? get count => _count;
  int? get rate => _rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['rate'] = _rate;
    return map;
  }
}
