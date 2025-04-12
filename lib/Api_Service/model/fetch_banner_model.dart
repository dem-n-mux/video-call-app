import 'dart:convert';

FetchBannerModel fetchBannerModelFromJson(String str) => FetchBannerModel.fromJson(json.decode(str));

String fetchBannerModelToJson(FetchBannerModel data) => json.encode(data.toJson());

class FetchBannerModel {
  FetchBannerModel({
    bool? status,
    String? message,
    List<Banner>? banner,
  }) {
    _status = status;
    _message = message;
    _banner = banner;
  }

  FetchBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['banner'] != null) {
      _banner = [];
      json['banner'].forEach((v) {
        _banner?.add(Banner.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Banner>? _banner;

  FetchBannerModel copyWith({
    bool? status,
    String? message,
    List<Banner>? banner,
  }) =>
      FetchBannerModel(
        status: status ?? _status,
        message: message ?? _message,
        banner: banner ?? _banner,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Banner>? get banner => _banner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_banner != null) {
      map['banner'] = _banner?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));

String bannerToJson(Banner data) => json.encode(data.toJson());

class Banner {
  Banner({
    String? id,
    String? url,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _url = url;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Banner.fromJson(dynamic json) {
    _id = json['_id'];
    _url = json['url'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _url;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Banner copyWith({
    String? id,
    String? url,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Banner(
        id: id ?? _id,
        url: url ?? _url,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get url => _url;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['url'] = _url;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
