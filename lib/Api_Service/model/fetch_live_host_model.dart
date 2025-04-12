import 'dart:convert';

FetchLiveHostModel fetchLiveHostModelFromJson(String str) =>
    FetchLiveHostModel.fromJson(json.decode(str));

String fetchLiveHostModelToJson(FetchLiveHostModel data) =>
    json.encode(data.toJson());

class FetchLiveHostModel {
  FetchLiveHostModel({
    bool? status,
    String? message,
    LiveHost? liveHost,
  }) {
    _status = status;
    _message = message;
    _liveHost = liveHost;
  }

  FetchLiveHostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _liveHost =
        json['liveHost'] != null ? LiveHost.fromJson(json['liveHost']) : null;
  }

  bool? _status;
  String? _message;
  LiveHost? _liveHost;

  FetchLiveHostModel copyWith({
    bool? status,
    String? message,
    LiveHost? liveHost,
  }) =>
      FetchLiveHostModel(
        status: status ?? _status,
        message: message ?? _message,
        liveHost: liveHost ?? _liveHost,
      );

  bool? get status => _status;

  String? get message => _message;

  LiveHost? get liveHost => _liveHost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveHost != null) {
      map['liveHost'] = _liveHost?.toJson();
    }
    return map;
  }
}

LiveHost liveHostFromJson(String str) => LiveHost.fromJson(json.decode(str));

String liveHostToJson(LiveHost data) => json.encode(data.toJson());

class LiveHost {
  LiveHost({
    String? id,
    num? view,
    bool? isInCall,
    String? liveStreamingId,
    String? name,
    String? country,
    String? image,
    String? token,
    String? channel,
    num? coin,
    String? hostId,
    String? dob,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _view = view;
    _isInCall = isInCall;
    _liveStreamingId = liveStreamingId;
    _name = name;
    _country = country;
    _image = image;
    _token = token;
    _channel = channel;
    _coin = coin;
    _hostId = hostId;
    _dob = dob;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LiveHost.fromJson(dynamic json) {
    _id = json['_id'];
    _view = json['view'];
    _isInCall = json['isInCall'];
    _liveStreamingId = json['liveStreamingId'];
    _name = json['name'];
    _country = json['country'];
    _image = json['image'];
    _token = json['token'];
    _channel = json['channel'];
    _coin = json['coin'];
    _hostId = json['hostId'];
    _dob = json['dob'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  num? _view;
  bool? _isInCall;
  String? _liveStreamingId;
  String? _name;
  String? _country;
  String? _image;
  String? _token;
  String? _channel;
  num? _coin;
  String? _hostId;
  String? _dob;
  String? _createdAt;
  String? _updatedAt;

  LiveHost copyWith({
    String? id,
    num? view,
    bool? isInCall,
    String? liveStreamingId,
    String? name,
    String? country,
    String? image,
    String? token,
    String? channel,
    num? coin,
    String? hostId,
    String? dob,
    String? createdAt,
    String? updatedAt,
  }) =>
      LiveHost(
        id: id ?? _id,
        view: view ?? _view,
        isInCall: isInCall ?? _isInCall,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
        name: name ?? _name,
        country: country ?? _country,
        image: image ?? _image,
        token: token ?? _token,
        channel: channel ?? _channel,
        coin: coin ?? _coin,
        hostId: hostId ?? _hostId,
        dob: dob ?? _dob,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  num? get view => _view;

  bool? get isInCall => _isInCall;

  String? get liveStreamingId => _liveStreamingId;

  String? get name => _name;

  String? get country => _country;

  String? get image => _image;

  String? get token => _token;

  String? get channel => _channel;

  num? get coin => _coin;

  String? get hostId => _hostId;

  String? get dob => _dob;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['view'] = _view;
    map['isInCall'] = _isInCall;
    map['liveStreamingId'] = _liveStreamingId;
    map['name'] = _name;
    map['country'] = _country;
    map['image'] = _image;
    map['token'] = _token;
    map['channel'] = _channel;
    map['coin'] = _coin;
    map['hostId'] = _hostId;
    map['dob'] = _dob;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
